using System;

namespace Task1.Model {
  public interface IEntity {
    int Id { get; set; }
  }
  public interface IAuditable {
    DateTime CreatedOn { get; set; }
    DateTime ModifiedOn { get; set; }
  }

  public interface IDeletable {
    DateTime? DeletedOn { get; set; }
    bool IsDeleted { get; set; }
  }

  public partial class Post : IEntity, IAuditable, IDeletable { }

  public partial class Comment : IEntity, IAuditable, IDeletable { }

  public partial class User : IEntity { }
}