---
title: "Reading Note: Model and Record Data Type in Elm"
tags: software functional elm
---

## Model

- The model is responsible for containing all your application states.
- The model in Elm is different from other architectures such as MVC, MVVM, or stuffing data in the DOM via data-* attributes. Those approaches encourage spreading your state across multiple models, making it hard to keep track of where the state is located and how and when the state changes. The Elm Architecture helps you know where your state is located. It is consolidated in one place.
- In Elm, the model can be whatever data type (String, Integer, etc). Typically, the model will be a record data type.

## Record Data Type

```elm
> dog = { name = "Tucker", age = 11 }
{ age = 11, name = "Tucker" } : { age : number, name: String }
```

- We use `{}` to create records. It is similar to creating Javascript objects.
- The significant difference between JavaScript objects and Elm records is that **records are static**. You won't be able to add new fields or change the type of the existing fields.
- In Elm, you cannot mutate values. So, records are **immutable**. Instead of mutating records, you can create new instances of records.

Let write a function for the dog to have a birthday:

```elm
> haveBirthday d = { name = d.name , age = d.age + 1 }
<function>
    : { b | age : number, name : a } -> { age : number, name : a }
```

The `haveBirthday` function takes a record of type b that must have an **age** field of type number and a **name** field of type a.

This is an extensive record.

Another example of extensive record:

```elm
type alias Contact c =
  { c
      | name : String
      , email : String
      , phone : String
  }
```

It means that any record with **name**, **email** and **phone** `String`  fields is a Contact.

Get back to the `haveBirthday` function, you can use it on the original dog to create a new instance of a dog record.

```elm
> olderDog = haveBirthday dog
{ age = 12, name = "Tucker" } : { age : number, name : String }

> dog
{ age = 11, name = "Tucker" } : { age : number, name: String }
```

So, when using Elm, you do not mutate the model values. You create a new value from the original one.

## References

- [Programming Elm](https://pragprog.com/titles/jfelm/programming-elm/)
