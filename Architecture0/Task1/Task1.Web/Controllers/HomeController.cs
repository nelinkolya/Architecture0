using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Newtonsoft.Json;
using Task1.Model;
using Task1.Web.Models;

namespace Task1.Web.Controllers {
  [Authorize]
  public class HomeController:Controller {
    public ActionResult Index() {
      return View();
    }

    public JsonResult GetPosts() {
      var repo = new Repository(new Task1DbContext());

      if (User.IsInRole("Admin")) {
        var list=repo.Get<Post>().OrderByDescending(x => x.CreatedOn).ToList();
        
        var listResult=new List<PostVm>();

        list.ForEach(x => {
          listResult.Add(new PostVm {
            Id = x.Id,
            CreatedOn = x.CreatedOn,
            IsDeleted = x.IsDeleted,
            UserName = x.User.UserName,
            Text = x.Text,
            UserId = x.UserId,
            Comments = x.Comment.Select(y=>new CommentVm {
              Id = y.Id,
              CreatedOn = y.CreatedOn,
              UserName = y.User.UserName,
              IsDeleted = y.IsDeleted,
              IsRecentlyCreated = true,
              PostId = y.PostId.Value,
              Text = y.Text,
              UserId = y.UserId
            }).ToList()
          });
        });
        return new JsonNetResult { Data = listResult, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
      }
      else {
        var list = repo.Get<Post>(x => !x.IsDeleted).OrderByDescending(x => x.CreatedOn).ToList();
        var listResult = new List<PostVm>();

        list.ForEach(x => {
          listResult.Add(new PostVm
          {
            Id = x.Id,
            CreatedOn = x.CreatedOn,
            IsDeleted = x.IsDeleted,
            UserId = x.UserId,
            UserName = x.User.UserName,
            Text = x.Text,
            Comments = x.Comment.Select(y => new CommentVm
            {
              Id = y.Id,
              CreatedOn = y.CreatedOn,
              UserName = y.User.UserName,
              IsDeleted = y.IsDeleted,
              IsRecentlyCreated = true,
              PostId = y.PostId.Value,
              Text = y.Text,
              UserId = y.UserId
            }).ToList()
          });
        });
        return new JsonNetResult { Data = listResult, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
      }
    }

    [HttpPost]
    public JsonResult SavePost(PostVm postVm) {
      var post = new Post {
        IsDeleted = postVm.IsDeleted,
        Text = postVm.Text,
        Id = postVm.Id,
        UserId = postVm.UserId,
        CreatedOn = postVm.CreatedOn
      };

      var repo = new Repository(new Task1DbContext());

      if (post.Id < 1) {
        post.UserId = User.Identity.GetUserId<int>();
        post.CreatedOn=DateTime.UtcNow;
        post.ModifiedOn=DateTime.UtcNow;

        repo.Add(post);
        repo.Commit();
      }
      else {
        post.CreatedOn = DateTime.UtcNow;
        post.ModifiedOn = DateTime.UtcNow;

        repo.Update(post);
        repo.Commit();
      }

      var result = repo.Get<Post>(x => x.Id == post.Id).Include(x => x.User).Include(x => x.Comment).First();
      var resultViewModel = new PostVm {
        Id = result.Id,
        CreatedOn = result.CreatedOn,
        IsDeleted = result.IsDeleted,
        UserId = result.UserId,
        Text = result.Text,
        UserName = result.User.UserName,
        Comments = result.Comment.Select(y => new CommentVm
        {
          Id = y.Id,
          CreatedOn = y.CreatedOn,
          UserName = y.User.UserName,
          IsDeleted = y.IsDeleted,
          IsRecentlyCreated = y.CreatedOn.AddHours(1) > DateTime.UtcNow,
          PostId = y.PostId.Value,
          UserId = y.UserId,
          Text = y.Text
        }).ToList()
      };

      return new JsonNetResult { Data = resultViewModel, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
    }


    [HttpPost]
    public JsonResult RemovePost(int postId) {
      var repo = new Repository(new Task1DbContext());

      var post = repo.Get<Post>(x => x.Id == postId).Include(x => x.Comment).First();
      post.IsDeleted = true;

      post.Comment.ToList().ForEach(c => c.IsDeleted = true);

      repo.Update(post);
      repo.Commit();

     var updated = repo.Get<Post>(x => x.Id == postId).Include(x => x.Comment).Include(x => x.User).First();
      var result = new PostVm {
        Id = updated.Id,
        CreatedOn = updated.CreatedOn,
        UserId = updated.UserId,
        IsDeleted = updated.IsDeleted,
        Text = updated.Text,
        UserName = updated.User.UserName,
        Comments = updated.Comment.Select(y => new CommentVm
        {
          Id = y.Id,
          CreatedOn = y.CreatedOn,
          UserName = y.User.UserName,
          IsDeleted = y.IsDeleted,
          IsRecentlyCreated = y.CreatedOn.AddHours(1) > DateTime.UtcNow,
          PostId = y.PostId.Value,
          UserId = y.UserId,
          Text = y.Text
        }).ToList()

      };

      return new JsonNetResult { Data = result, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
    }

    [HttpPost]
    public JsonResult RemoveComment(int commentId) {
      var repo = new Repository(new Task1DbContext());

      var comment = repo.Get<Comment>(commentId);
      comment.IsDeleted = true;
      repo.Update(comment);
      repo.Commit();

      var updated = repo.Get<Comment>(x => x.Id == comment.Id).Include(x => x.User).First();

      var result = new CommentVm {
        CreatedOn = updated.CreatedOn,
        Text = updated.Text,
        Id = updated.Id,
        IsDeleted = updated.IsDeleted,
        UserName = updated.User.UserName,
        UserId = updated.UserId,
        IsRecentlyCreated = updated.CreatedOn.AddHours(1) > DateTime.UtcNow,
        PostId = updated.PostId.Value
      };
      return new JsonNetResult { Data = result, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
    }

    [HttpPost]
    public JsonResult SaveComment(CommentVm commentVm) {
      var repo = new Repository(new Task1DbContext());

      var comment = new Comment
      {
        CreatedOn = commentVm.CreatedOn,
        Text = commentVm.Text,
        Id = commentVm.Id,
        IsDeleted = commentVm.IsDeleted,
        UserId = commentVm.UserId,
        PostId = commentVm.PostId
      };

      if (comment.Id < 1) {
        comment.CreatedOn = DateTime.UtcNow;
        comment.ModifiedOn = DateTime.UtcNow;
        comment.UserId = User.Identity.GetUserId<int>();
        repo.Add(comment);
        repo.Commit();
      }
      else {
        comment.CreatedOn = DateTime.UtcNow;
        comment.ModifiedOn = DateTime.UtcNow;
        repo.Update(comment);
        repo.Commit();
      }

      var result = repo.Get<Comment>(x => x.Id == comment.Id).Include(x => x.User).First();

      var result2 = new CommentVm
      {
        CreatedOn = result.CreatedOn,
        Text = result.Text,
        Id = result.Id,
        IsDeleted = result.IsDeleted,
        UserName = result.User.UserName,
        UserId = result.UserId,
        IsRecentlyCreated = result.CreatedOn.AddHours(1) > DateTime.UtcNow,
        PostId = result.PostId.Value
      };
      return new JsonNetResult { Data = result2, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
    }

    [AllowAnonymous]
    public JsonResult GetCurrentUser() {
      var repo = new Repository(new Task1DbContext());

      var userId = User.Identity.GetUserId<int>();
      var user = userId == 0 ? null : repo.Get<User>(x => x.Id == userId).Include(u => u.Role).First();

      var userView = new UserVm {
        UserName = user.UserName,
        Id = user.Id,
        CanSeeDeleted = user.Role.Select(x=>x.Name).ToList().Contains("Admin"),
        CanAddPosts = user.Role.Select(x => x.Name).ToList().Contains("Admin"),
        CanDeleteComments = user.Role.Select(x => x.Name).ToList().Contains("Admin") && user.Role.Select(x => x.Name).ToList().Contains("Manager"),
        CanEditComments = user.Role.Select(x => x.Name).ToList().Contains("Admin") && user.Role.Select(x => x.Name).ToList().Contains("Manager"),
        CanDeletePosts = user.Role.Select(x => x.Name).ToList().Contains("Admin") && user.Role.Select(x => x.Name).ToList().Contains("Manager"),
        CanEditPosts = user.Role.Select(x => x.Name).ToList().Contains("Admin") && user.Role.Select(x => x.Name).ToList().Contains("Manager")
      };

      userView.Roles = "";

      user.Role.Select(x => x.Name).ToList().ForEach(x => {
        userView.Roles += (x + ",");
      });
      return new JsonNetResult { Data = userView, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
    }
  }




  public class JsonNetResult : JsonResult {
    public override void ExecuteResult(ControllerContext context)
    {
      HttpResponseBase response = context.HttpContext.Response;
      response.ContentType = "application/json";
      if (ContentEncoding != null)
        response.ContentEncoding = ContentEncoding;
      if (Data != null)
      {
        JsonTextWriter writer = new JsonTextWriter(response.Output)
        {
          Formatting = Formatting.Indented,
          DateTimeZoneHandling = DateTimeZoneHandling.Utc,
          DateFormatHandling = DateFormatHandling.IsoDateFormat
        };
        JsonSerializer serializer = JsonSerializer.Create(new JsonSerializerSettings
        {
          DateTimeZoneHandling = DateTimeZoneHandling.Utc,
          ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
          DateFormatHandling = DateFormatHandling.IsoDateFormat
        });
        serializer.Serialize(writer, Data);
        writer.Flush();
      }
    }
  }
}