using System;
using System.Linq;
using AutoMapper;
using Task1.Model;
using Task1.Web.Infrastracture.Extensions;
using Task1.Web.Models;

namespace Task1.Web.Infrastracture.Mappings {
  public class PostMappings : Profile {
    public PostMappings() {
      CreateMap<Comment, CommentVm>()
        .ForMember(m => m.UserName, opt => opt.MapFrom(src => src.User.UserName))
        .ForMember(m => m.IsRecentlyCreated, opt => opt.MapFrom(src => (src.CreatedOn.AddHours(1) > DateTime.UtcNow)));

      CreateMap<CommentVm, Comment>();

      CreateMap<Comment, Comment>();

      CreateMap<Post, PostVm>()
        .ForMember(m => m.UserName, opt => opt.MapFrom(src => src.User.UserName))
        .ForMember(m => m.Comments, opt => opt.MapFrom(src => src.Comment.ToList().OrderByDescending(x=>x.CreatedOn).To<CommentVm>()));

      CreateMap<PostVm, Post>();
    }
  }
}