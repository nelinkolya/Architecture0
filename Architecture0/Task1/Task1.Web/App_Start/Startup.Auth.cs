using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using Owin;
using Task1.Web.Models;
using Task1.Web.Providers;

namespace Task1.Web {
  public partial class Startup {
    // Enable the application to use OAuthAuthorization. You can then secure your Web APIs
    static Startup() {
      PublicClientId = "web";

      OAuthOptions = new OAuthAuthorizationServerOptions {
        TokenEndpointPath = new PathString("/Token"),
        AuthorizeEndpointPath = new PathString("/Account/Authorize"),
        Provider = new ApplicationOAuthProvider(PublicClientId),
        AccessTokenExpireTimeSpan = TimeSpan.FromDays(14),
        AllowInsecureHttp = true
      };
    }

    public static OAuthAuthorizationServerOptions OAuthOptions { get; }

    public static string PublicClientId { get; }

    public void ConfigureAuth(IAppBuilder app) {
      // Configure the db context, user manager and signin manager to use a single instance per request
      app.CreatePerOwinContext(ApplicationDbContext.Create);
      app.CreatePerOwinContext<ApplicationUserManager>(ApplicationUserManager.Create);
      app.CreatePerOwinContext<ApplicationSignInManager>(ApplicationSignInManager.Create);

      // Enable the application to use a cookie to store information for the signed in user
      app.UseCookieAuthentication(new CookieAuthenticationOptions {
        AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
        LoginPath = new PathString("/Account/Login"),
        Provider = new CookieAuthenticationProvider {
          OnValidateIdentity = SecurityStampValidator
            .OnValidateIdentity<ApplicationUserManager, ApplicationUser, int>(TimeSpan.FromMinutes(30),
              (manager, user) =>
                user.GenerateUserIdentityAsync(manager), id => id.GetUserId<int>())
        }
      });
      // Use a cookie to temporarily store information about a user logging in with a third party login provider
      app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

      // Enables the application to temporarily store user information when they are verifying the second factor in the two-factor authentication process.
      app.UseTwoFactorSignInCookie(DefaultAuthenticationTypes.TwoFactorCookie, TimeSpan.FromMinutes(5));

      app.UseTwoFactorRememberBrowserCookie(DefaultAuthenticationTypes.TwoFactorRememberBrowserCookie);

      // Enable the application to use bearer tokens to authenticate users
      app.UseOAuthBearerTokens(OAuthOptions);
    }
  }
}