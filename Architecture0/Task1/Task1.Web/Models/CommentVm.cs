using System;

namespace Task1.Web.Models {
  public class CommentVm {
    public int Id { get; set; }
    public int UserId { get; set; }
    public int PostId { get; set; }
    public string Text { get; set; }
    public string UserName { get; set; }
    public DateTime CreatedOn { get; set; }
    public int Likes { get; set; }
    public int Dislikes { get; set; }
    public bool IsDeleted { get; set; }
    public bool IsRecentlyCreated { get; set; }
  }
}