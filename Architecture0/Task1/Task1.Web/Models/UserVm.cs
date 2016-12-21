namespace Task1.Web.Models {
  public class UserVm {
    public string UserName { get; set; }
    public int Id { get; set; }
    public string Roles { get; set; }
    public bool CanAddPosts { get; set; }
    public bool CanEditPosts { get; set; }
    public bool CanDeletePosts { get; set; }
    public bool CanEditComments { get; set; }
    public bool CanDeleteComments { get; set; }
    public bool CanSeeDeleted { get; set; }
  }
}