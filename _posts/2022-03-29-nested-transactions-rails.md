---
title: "Reading Note: Nested transactions in Rails"
tags: software ruby rails backend
---

`transaction` calls can be nested. By default, this makes all database statements in the nested transaction block become part of the parent transaction. **(1)**

Example:

```ruby
User.transaction do
  User.create(username: 'Hisoka')
  User.transaction do
    User.create(username: 'Gon')
    raise ActiveRecord::Rollback
  end
end
```

Try to write this code in your `rails console`. You will see that this code creates both "Hisoka" and "Gon" (you will know who they are after you read [Hunter × Hunter](https://en.wikipedia.org/wiki/Hunter_%C3%97_Hunter)).

The reason is the `ActiveRecord::Rollback` exception in the nested block does not issue a **ROLLBACK**. Since these exceptions are captured in transaction blocks, the parent block does not see it and the real transaction is committed.

Try adding `requires_new: true`

```ruby
User.transaction do
  User.create(username: 'Hisoka')
  User.transaction(requires_new: true) do
    User.create(username: 'Gon')
    raise ActiveRecord::Rollback
  end
end
```

Now, only "Hisoka" is created.

`requires_new: true`  means if anything goes wrong, the database rolls back to the beginning of the sub-transaction without rolling back the parent transaction.

Now, we look at another example here:

```ruby
class AnimeCharacter < ActiveRecord::Base
  after_save :do_something

  def do_something
    raise ActiveRecord::Rollback
  end
end
```

Let try to update a character name:

```ruby
my-buggy> AnimeCharacter.first.name
# => "Hisoka"
my-buggy> AnimeCharacter.first.update!(name: "Kurapika")
# => ROLLBACK
my-buggy> AnimeCharacter.first.name
#=> "Hisoka"
```

It works as expected. Now we try to update the record inside a transaction.

```ruby
my-buggy> AnimeCharacter.first.name
# => "Hisoka"
my-buggy> ActiveRecord::Base.transaction { AnimeCharacter.first.update!(name: "Kurapika") }
# => COMMIT
my-buggy> AnimeCharacter.first.name
#=> "Kurapika"
```

Why? Let revise **(1)**. The **update!** method opens its transaction here. It is nested inside our custom transaction.

In this case, we will add `joinable: false`

```ruby
my-buggy> AnimeCharacter.first.name
# => "Hisoka"
my-buggy> ActiveRecord::Base.transaction(joinable: false) { AnimeCharacter.first.update!(name: "Kurapika") }
# => COMMIT
my-buggy> AnimeCharacter.first.name
#=> "Kurapika"
```

`joinable: false` means transactions nested within this transaction will not be discarded (**and therefore not be joined to the custom transaction**). A real nested transaction will be used. If the DBMS does not support the nested transactions, this behavior will be simulated with Savepoints (this is done for MySQL and Postgres).

So, we should always use both `joinable: false` and `requires_new: true` when using the custom transaction.

## References

- <https://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html>
- <https://makandracards.com/makandra/42885-nested-activerecord-transaction-pitfalls>
