using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using Task1.Model;
using Task1.Web.Enums;
using Task1.Web.Infrastracture.Extensions;
using Task1.Web.Models;
using WebGrease.Css.Extensions;

namespace Task1.Web.Controllers {
  [Authorize]
  public class HomeController : ControllerBase {
    private readonly IRepository _repository;

    public HomeController(IRepository repository) {
      _repository = repository;
    }

    public ActionResult Index() {
      return View();
    }

    public JsonResult GetPosts() {
      return JsonEx(
        User.IsInRole(UserRoles.Admin.ToString())
          ? _repository.Get<Post>().OrderByDescending(x => x.CreatedOn).To<PostVm>()
          : _repository.Get<Post>(x => !x.IsDeleted).OrderByDescending(x => x.CreatedOn).To<PostVm>());
    }

    [HttpPost]
    public JsonResult SavePost(PostVm postVm) {
      var post = postVm.To<Post>();

      var isNew = post.Id < 1;

      if (isNew) {
        post.UserId = GetCurrentUserId();
        _repository.Add(post);
      }
      else {
        _repository.Update(post);
      }
      _repository.Commit();

      var result = _repository.Get<Post>(x => x.Id == post.Id).Include(x => x.User).Include(x => x.Comment).First().To<PostVm>();
      return JsonEx(result);
    }


    [HttpPost]
    public JsonResult RemovePost(int postId) {
      var post = _repository.Get<Post>(x => x.Id == postId).Include(x => x.Comment).First();
      post.IsDeleted = true;

      post.Comment.ForEach(c => c.IsDeleted = true);

      _repository.Update(post);
      _repository.Commit();

      return
        JsonEx(
          _repository.Get<Post>(x => x.Id == postId).Include(x => x.Comment).Include(x => x.User).First().To<PostVm>());
    }

    [HttpPost]
    public JsonResult RemoveComment(int commentId) {
      var comment = _repository.Get<Comment>(commentId);
      comment.IsDeleted = true;
      _repository.Update(comment);
      _repository.Commit();

      return JsonEx(_repository.Get<Comment>(x => x.Id == commentId).Include(x => x.User).First().To<CommentVm>());
    }

    [HttpPost]
    public JsonResult SaveComment(CommentVm commentVm) {
      var comment = commentVm.To<Comment>();

      var isNew = comment.Id < 1;

      if (isNew) {
        comment.UserId = GetCurrentUserId();
        _repository.Add(comment);
      }
      else {
        _repository.Update(comment);
      }
      _repository.Commit();

      var result = _repository.Get<Comment>(x => x.Id == comment.Id).Include(x => x.User).First().To<CommentVm>();
      return JsonEx(result);
    }

    [AllowAnonymous]
    public JsonResult GetCurrentUser() {
      var userId = GetCurrentUserId();
      var user = userId == 0 ? null : _repository.Get<User>(x => x.Id == userId).Include(u => u.Role).First();
      return JsonEx(user.To<UserVm>());
    }
  }
}