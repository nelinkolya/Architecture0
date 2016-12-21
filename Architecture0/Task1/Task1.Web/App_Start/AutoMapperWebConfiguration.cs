using System;
using System.Linq;
using System.Reflection;
using AutoMapper;
using WebGrease.Css.Extensions;

namespace Task1.Web {
  public static class AutoMapperWebConfiguration {
    public static void Configure() {
      var profileType = typeof (Profile);
      // Get an instance of each Profile in the executing assembly.
      var profiles = Assembly.GetExecutingAssembly().GetTypes()
        .Where(t => profileType.IsAssignableFrom(t)
                    && t.GetConstructor(Type.EmptyTypes) != null)
        .Select(Activator.CreateInstance)
        .Cast<Profile>();

      // Initialize AutoMapper with each instance of the profiles found.
      Mapper.Initialize(a => profiles.ForEach(a.AddProfile));
    }
  }
}