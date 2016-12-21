using System;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace Task1.Model {
  public class Repository : IRepository {
    private readonly Task1DbContext _context;

    public Repository(Task1DbContext context) {
      _context = context;
    }

    public T Get<T>(int entityId) where T : class, IEntity {
      return _context.Set<T>().Find(entityId);
    }

    public IQueryable<T> Get<T>(Expression<Func<T, bool>> predicate = null) where T : class, IEntity
    {
      return predicate == null ? _context.Set<T>() : _context.Set<T>().Where(predicate);
    }

    public IQueryable<T> Get<T>(Expression<Func<T, bool>> predicate,
      Func<IQueryable<T>, IQueryable<T>> entityInclude) where T : class, IEntity
    {
      var result = Get(predicate);

      return entityInclude == null
        ? result
        : entityInclude(result);
    }

    public void Update<T>(T model) where T : class, IEntity {
      var old = _context.Set<T>().AsNoTracking().First(x => x.Id == model.Id);

      var deletable = model as IDeletable;
      var auditable = model as IAuditable;

      if (deletable != null && deletable.IsDeleted) {
        deletable.DeletedOn = DateTime.UtcNow;
      }

      if (auditable != null) {
        auditable.CreatedOn = (old as IAuditable).CreatedOn;
        auditable.ModifiedOn = DateTime.UtcNow;
      }

      var entity = _context.Set<T>().Attach(model);
      _context.Entry(entity).State = EntityState.Modified;
    }

    public void Remove<T>(T entity) where T : class, IEntity
    {
      _context.Set<T>().Remove(entity);
    }

    public void Add<T>(T entity) where T : class, IEntity
    {
      var auditable = entity as IAuditable;

      if (auditable != null) {
        auditable.CreatedOn = DateTime.UtcNow;
        auditable.ModifiedOn = DateTime.UtcNow;
      }

      _context.Set<T>().Add(entity);
    }

    public void Commit() {
      _context.SaveChanges();
    }

    public void Dispose() {}
  }
}