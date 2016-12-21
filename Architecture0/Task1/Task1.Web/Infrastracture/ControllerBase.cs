using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Newtonsoft.Json;

// ReSharper disable CheckNamespace

namespace Task1.Web {
  public class ControllerBase : Controller {
    protected JsonResult JsonEx(object data) {
      return new JsonNetResult {Data = data, JsonRequestBehavior = JsonRequestBehavior.AllowGet};
    }

    public class JsonNetResult : JsonResult {
      public override void ExecuteResult(ControllerContext context) {
        HttpResponseBase response = context.HttpContext.Response;
        response.ContentType = "application/json";
        if (ContentEncoding != null)
          response.ContentEncoding = ContentEncoding;
        if (Data != null) {
          JsonTextWriter writer = new JsonTextWriter(response.Output) {
            Formatting = Formatting.Indented,
            DateTimeZoneHandling = DateTimeZoneHandling.Utc,
            DateFormatHandling = DateFormatHandling.IsoDateFormat
          };
          JsonSerializer serializer = JsonSerializer.Create(new JsonSerializerSettings {
            DateTimeZoneHandling = DateTimeZoneHandling.Utc,
            ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
            DateFormatHandling = DateFormatHandling.IsoDateFormat
          });
          serializer.Serialize(writer, Data);
          writer.Flush();
        }
      }
    }

    protected int GetCurrentUserId() {
      return User.Identity.GetUserId<int>();
    }
  }
}