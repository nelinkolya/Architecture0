﻿using System;
using System.Linq;
using System.Linq.Expressions;

namespace Task1.Web {
  public interface IRepository : IDisposable {
    T Get<T>(int entityId) where T : class;

    IQueryable<T> Get<T>(Expression<Func<T, bool>> predicate = null) where T : class;

    IQueryable<T> Get<T>(Expression<Func<T, bool>> predicate,
      Func<IQueryable<T>, IQueryable<T>> entityInclude) where T : class;

    void Update<T>(T model) where T : class;

    void Remove<T>(T entity) where T : class;

    void Add<T>(T entity) where T : class;

    void Commit();
  }
}