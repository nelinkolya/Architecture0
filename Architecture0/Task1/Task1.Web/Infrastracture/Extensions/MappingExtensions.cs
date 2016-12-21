using System.Collections.Generic;
using System.Linq;
using AutoMapper;

namespace Task1.Web.Infrastracture.Extensions {
  public static class MappingExtensions {
    public static TOutput To<TOutput>(this object input) {
      return Mapper.Map<TOutput>(input);
    }

    public static List<TOutput> To<TOutput>(this IEnumerable<object> input) {
      return input.Select(Mapper.Map<TOutput>).ToList();
    }
  }
}
