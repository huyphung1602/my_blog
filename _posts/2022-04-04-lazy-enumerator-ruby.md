---
title: "Lazy Enumerator in Ruby"
tags: software ruby
---

`Enumerator::Lazy` allows constructing chains of operations without evaluating them immediately, and evaluating values on an as-needed basis.

It redefines most of the Enumerable methods so that they just construct another lazy enumerator.

## What is an enumerator?

Each time we use enumerable methods like `map`, `collect`, `select`, we create an enumerator class. The enumerable objects can be chained.

```ruby
[1, 2, 3].map { ... }.select { ... }
```

### Normal Enumerator

Let's say, we have to fetch 10 Twitter users' profiles, who have `@anime` in their profile bio.
Assume, we have 1000 Twitter user IDs. Simply, we may do this to fetch 10 users:

```ruby
# Array of user ids
user_ids = [...]

user_ids.map { |user_id| TwitterClient.user(user_id) }
        .select { |data| data[:description].includes?("@anime") }
        .first(10)
```

This code iterated 1000 users, even if the first 10 users had `@anime` in their descriptions.

Let's say about another case.

- We have an infinity `range = 1..Float::INFINITY`
- We want to output the square of the first 10 members from this range 

Let's try running it without `lazy`

```ruby
range = 1..Float::INFINITY
range.collect { |x| x**2 }.first 5
```

This code in `irb` will run forever because the `collect` method will loop through all the members of an `infinity` range.

### Lazy Enumerator

The Lazy Enumerator was added to ruby from version 2.0

In the first example:

```ruby
# Array of user ids
user_ids = [...]

user_ids.lazy
        .map { |user_id| TwitterClient.user(user_id) }
        .select { |data| data[:description].includes?("@anime") }
        .first(10)
```

The iteration ends after we fetched 10 matched condition users.

In the second example:

```ruby
range = 1..Float::INFINITY
range.lazy.collect { |x| x**2 }.first 5
```

The iteration will end after it takes the first 5 numbers.

When using lazy enumerable methods, `ruby` will return an instance of `Enumerator::Lazy` containing the previous Enumerable. Then, we call the other supported methods such as `collect`, `take`, `drop`. Instead of evaluating the block's result and pass to the next block, ruby will construct and return the new `Enumerator::Lazy` containing the previous `Enumerator::Lazy`.

```ruby
irb(main):003:0> range = 1..Float::INFINITY
=> 1..Infinity
irb(main):004:0> enum = range.lazy.collect{|x| x+1; p x+1}.collect{|x| x*2; p x*2}
=> #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: 1..Infinity>:collect>:collect>
```

You also have to make sure you are using the methods that are supported by [Enumerator::Lazy](https://ruby-doc.org/core-3.1.1/Enumerator/Lazy.html).

You also want to know that [Haskell uses lazy evaluation by default](https://techblog.rosedu.org/haskell-part2.html).

## References

- <https://ruby-doc.org/core-3.1.1/Enumerator/Lazy.html>
- <https://blog.saeloun.com/2019/10/23/ruby-lazy-enumerators.html>
- <https://viblo.asia/p/lazy-enumerable-trong-ruby-RnB5pNnrZPG>
- <https://mixandgo.com/learn/ruby/enumerable>
