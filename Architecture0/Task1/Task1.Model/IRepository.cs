using System;
using System.Linq;
using System.Linq.Expressions;

namespace Task1.Model {
  public interface IRepository : IDisposable {
    T Get<T>(int entityId) where T : class, IEntity;

    IQueryable<T> Get<T>(Expression<Func<T, bool>> predicate = null) where T : class, IEntity;

    IQueryable<T> Get<T>(Expression<Func<T, bool>> predicate,
      Func<IQueryable<T>, IQueryable<T>> entityInclude) where T : class, IEntity;

    void Update<T>(T model) where T : class, IEntity;

    void Remove<T>(T entity) where T : class, IEntity;

    void Add<T>(T entity) where T : class, IEntity;

    void Commit();
  }
}