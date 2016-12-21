using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace Task1.Web.Models {
  public class ApplicationUser : IdentityUser<int, CustomUserLogin, CustomUserRole, CustomUserClaim> {
    public string Hometown { get; set; }

    public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser, int> manager) {
      // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
      var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
      // Add custom user claims here
      return userIdentity;
    }
  }

  public class CustomUserRole : IdentityUserRole<int> {}

  public class CustomUserClaim : IdentityUserClaim<int> {}

  public class CustomUserLogin : IdentityUserLogin<int> {}

  public class CustomRole : IdentityRole<int, CustomUserRole> {
    public CustomRole() {}

    public CustomRole(string name) {
      Name = name;
    }
  }

  public class CustomUserStore : UserStore<ApplicationUser, CustomRole, int,
    CustomUserLogin, CustomUserRole, CustomUserClaim> {
    public CustomUserStore(ApplicationDbContext context)
      : base(context) {}
  }

  public class CustomRoleStore : RoleStore<CustomRole, int, CustomUserRole> {
    public CustomRoleStore(ApplicationDbContext context)
      : base(context) {}
  }

  public class ApplicationDbContext :
    IdentityDbContext<ApplicationUser, CustomRole, int, CustomUserLogin, CustomUserRole, CustomUserClaim> {
    public ApplicationDbContext()
      : base("IdentityDbContext") {}

    public static ApplicationDbContext Create() {
      return new ApplicationDbContext();
    }

    protected override void OnModelCreating(DbModelBuilder modelBuilder) {
      base.OnModelCreating(modelBuilder);

      modelBuilder.Entity<ApplicationUser>()
        .ToTable("User");

      modelBuilder.Entity<CustomRole>()
        .ToTable("Role");

      modelBuilder.Entity<CustomUserRole>()
        .ToTable("UserRole");

      modelBuilder.Entity<CustomUserClaim>()
        .ToTable("UserClaim");

      modelBuilder.Entity<CustomUserLogin>()
        .ToTable("UserLogin");
    }
  }
}