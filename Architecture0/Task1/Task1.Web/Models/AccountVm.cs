using System.ComponentModel.DataAnnotations;

namespace Task1.Web.Models {
  public class LoginVm {
    public string UserName { get; set; }

    [Required]
    [DataType(DataType.Password)]
    [Display(Name = "Password")]
    public string Password { get; set; }
  }
}