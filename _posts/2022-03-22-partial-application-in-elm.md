---
title: "Reading Note: Partially Apply Arguments in Elm"
tags: software functional elm
---

In many OOP programming languages such as Ruby. You have to fully apply the arguments when calling a function.

```ruby
def say_hello(greet, person_name)
  puts "#{greet} #{person_name}"
end

say_hello('Hi', 'Huy Phung') # Hi Huy Phung
```

In many functional programming languages such as Haskell, or Elm. You can partially apply the arguments when calling a function.

```elm
sayHello : String -> String -> String
sayHello greet personName =
  greet ++ " " ++ personName

> hello = sayHello "Hello"
<function> : String -> String
> hello "Tai Nguyen"
"Hello Tai Nguyen" : String
```

## What happens in Elm?

1. When you call the `sayHello` function with its first argument, you filled in the first argument with the value "Hello".
2. Then, Elm returns another function that is waiting for the value for the second argument (`person_name`).
3. Finally, you passed the second argument, Elm will know all the arguments have values and it returns the final result.

So, we have two concepts here:

- Filling one argument at a time is known as **partial application**.
- A function that can take one argument at a time is called **curried function**.

## Another way to create the function

With the partial application, you can create the new functions by applying the arguments partially.

```elm
> hello = sayHello "Hello"
<function> : String -> String
> hi = sayHello "Hi"
<function> : String -> String
> ciao = sayHello "Ciao"
<function> : String -> String

> hello "Gon"
"Hello Gon" : String
> hi "Gon"
"Hi Gon" : String
> ciao "Gon"
"Ciao Gon" : String
> hi "Killua"
"Hi Killua" : String
```

The note is based on a topic I read in the book [Programming Elm](https://pragprog.com/titles/jfelm/programming-elm/) by Jeremy Fairbank
