using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Owin;
using Task1.Web;
using Task1.Web.Enums;
using Task1.Web.Models;

[assembly: OwinStartup(typeof (Startup))]

namespace Task1.Web {
  public partial class Startup {
    public void Configuration(IAppBuilder app) {
      ConfigureAuth(app);
      InitUserRoles();
    }

    private static void InitUserRoles() {
      var context = new ApplicationDbContext();

      var roleManager = new RoleManager<CustomRole, int>(new CustomRoleStore(context));
      var userManager = new UserManager<ApplicationUser, int>(new CustomUserStore(context));

      if (!roleManager.RoleExists(UserRoles.Admin.ToString())) {
        //create user with admin permissions
        var role = new CustomRole(UserRoles.Admin.ToString());
        roleManager.Create(role);

        const string email = "nikolay.nelin@gmail.com";
        var admin = new ApplicationUser {
          UserName = email,
          Email = email
        };

        const string password = "1111aA!";
        var result = userManager.Create(admin, password);

        if (result.Succeeded) {
          userManager.AddToRole(admin.Id, UserRoles.Admin.ToString());
        }
      }

      if (!roleManager.RoleExists(UserRoles.Manager.ToString())) {
        var role = new CustomRole(UserRoles.Manager.ToString());
        roleManager.Create(role);
      }

      if (!roleManager.RoleExists(UserRoles.Customer.ToString())) {
        var role = new CustomRole(UserRoles.Customer.ToString());
        roleManager.Create(role);
      }
    }
  }
}