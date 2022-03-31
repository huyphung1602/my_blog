---
title: "Rails Reflection Methods"
tags: software rails ruby backend
---

Imagine that you have a file system application to manage contents with a `Category` model

```ruby
class Category < ApplicationRecord
  has_many :books, dependent: :restrict_with_error
  has_many :posts, dependent: :restrict_with_exception
end
```

So, if you try to destroy a `Category` record that contains 2 books and 1 post `category_1.destroy!`. You will fail to destroy it because there are dependencies.

Now, you have to implement a feature that **disables the delete button on the UI if a category could not be destroyed** instead of showing the error when the end-user tries to delete the items.

In an easy way, you can do this:

```ruby
class Category < ApplicationRecord
  ...

  def destroyable?
    !(self.books.any? || self.posts.any?)
  end
end
```

However, when your application grows bigger and there are many more things that need to be restricted before destroying a category record. You have to update the `destroyable?` method above each time. For example:

```ruby
class Category < ApplicationRecord
  has_many :books, dependent: :restrict_with_error
  has_many :posts, dependent: :restrict_with_exception
  has_one :metadata_file, dependent: :restrict_with_error

  def destroyable?
    !(self.books.any? || self.posts.any? || self.metadata_file.any?)
  end
end
```

Then, you introduce a Reference Model. This model represents the relationship when a post refers to a book.

```ruby
class Post < ApplicationRecord
  has_many :reference_books, through: references, source: referenceable, source_type: Book, dependent: :restrict_with_error
end
```

You also want to check if a Post is `destroyable?`

```ruby
class Post < ApplicationRecord
  ...

  def destroyable?
    !reference_books.any?
  end
end
```

The `destroyable?` is duplicated in these two models now. It is time to write something that is dynamic and you could not worry about updating these `destroyable?` methods.

ActiveRecord provides [reflection methods](http://api.rubyonrails.org/classes/ActiveRecord/Reflection/ClassMethods.html) for obtaining info on the associations. We will use the `reflect_on_all_associations` to iterate through model associations and check if the restriction list is empty or not.

```ruby
module Destroyable
  extend ActiveSupport::Concern

  def destroyable?
    self.class.reflect_on_all_associations.all? do |assoc|
      [
        %i[restrict_with_error restrict_with_exception].exclude?(assoc.options[:dependent]),
        (assoc.macro == :has_one && send(assoc.name).nil?),
        (assoc.macro == :has_many && send(assoc.name).empty?)
      ].any?
    end
  end
end
```

And now we could reuse it in our models.

```ruby
class Category < ApplicationRecord
  ...

  include Destroyable
end

class Post < ApplicationRecord
  ...

  include Destroyable
end
```

There are some notices from me when you use this one:

- You should have good unit tests on this destroyable? method to check if there is an issue related to the newer rails version.
- You also need to care about your application code loading strategy (check [Eager loading for greater good](http://blog.plataformatec.com.br/2012/08/eager-loading-for-greater-good/)). It is better to add `Rails.application.eager_load!` at the first line of your `destroyable?` method.

## In short

The `reflection methods` are useful in some specific cases. You should consider it carefully before applying it to your application. It is powerful if you use it right. It is dangerous if you overuse it.

## References

- <https://api.rubyonrails.org/classes/ActiveRecord/Reflection/ClassMethods.html>
- <https://manas.tech/blog/2012/01/31/how-to-check-if-object-can-be-destroyed-if-it-has-dependent-destroy-associations/>
- <http://blog.plataformatec.com.br/2012/08/eager-loading-for-greater-good/>
