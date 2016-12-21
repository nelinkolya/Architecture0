using System.Linq;
using AutoMapper;
using Task1.Model;
using Task1.Web.Enums;
using Task1.Web.Models;

namespace Task1.Web.Infrastracture.Mappings
{
  public class UserMappings:Profile
  {
    public UserMappings() {
      CreateMap<User, UserVm>()
        .ForMember(m => m.Roles, opt => opt.MapFrom(src => string.Join(",", src.Role.Select(r => r.Name))))
        .ForMember(m => m.CanAddPosts, opt => opt.MapFrom(src => src.Role.Select(x => x.Name).Contains(UserRoles.Admin.ToString())))
        .ForMember(m => m.CanEditPosts, opt => opt.MapFrom(src => src.Role.Select(x => x.Name).Contains(UserRoles.Admin.ToString()) && src.Role.Select(x => x.Name).Contains(UserRoles.Manager.ToString())))
        .ForMember(m => m.CanDeletePosts, opt => opt.MapFrom(src => src.Role.Select(x => x.Name).Contains(UserRoles.Admin.ToString()) && src.Role.Select(x => x.Name).Contains(UserRoles.Manager.ToString())))
        .ForMember(m => m.CanDeleteComments, opt => opt.MapFrom(src => src.Role.Select(x => x.Name).Contains(UserRoles.Admin.ToString()) && src.Role.Select(x => x.Name).Contains(UserRoles.Manager.ToString())))
        .ForMember(m => m.CanEditComments, opt => opt.MapFrom(src => src.Role.Select(x => x.Name).Contains(UserRoles.Admin.ToString()) && src.Role.Select(x => x.Name).Contains(UserRoles.Manager.ToString())))
        .ForMember(m => m.CanSeeDeleted, opt => opt.MapFrom(src => src.Role.Select(x => x.Name).Contains(UserRoles.Admin.ToString())));
    }
  }
}