---
title: "Reading Note: Nominal type and Structural type"
tags: software type-system
---

Today I learn that an important attribute of every type system is whether they are **structural** or **nominal**.

A static type checker uses either the names or the structure of the types to compare them against other types. Checking against the name is nominal typing and checking against the structure is structural typing.

## Nominal Type

In a **nominal**, or **nominative**, or **name-based type system**, two types are deemed to be the same if they have the same name.

**Subtyping:** type T1 is deemed to be a subtype of a type T2 if T1 is **explicitly declared** to be a subtype of T2.

Example:

```js
class Person {
    public name: string;
}

class Employee extends Person {
    public salary: number;
}

class Manager extends Employee { }

class Product {
    public name: string;
    public price: number;
}
```

- `Employee` is a subtype of `Person` because it is declared as such using the keyword "extends" in the class declaration.
- `Product` is not a subtype of `Person` because it does not use the "extends" declaration.

## Structural Type

In a structural type system, two types are deemed the same if they are of the **same structure**. Two types are the same in structure if they have the same public fields and methods of compatible type/signature.

**Subtyping:** Type T1 is deemed a subtype of a type T2 if and only if T1 has all public members (of compatible type/signature) that T2 has (but may have more than T2).

Let's look at the previous code.

- In nominal, `Product` is not a subtype of `Person`.
- In structural, `Product` is deemed a structural subtype of `Person` because it has all of Person's public members of compatible type (only field `name` in this case).
- In structural, `Person` is not a subtype of Product because it lacks Product's field `price`

## Comparison

- Structural typing is more flexible than nominal typing.
- Nominal typing is a better type-safety than structural type.
- A pitfall of structural typing versus nominative typing is that two separately defined types are intended for a different purpose, but accidentally hold the same properties and be considered the same type by the type system. One solution for this is to create one **algebraic data type** for each use.

## References

- <https://en.wikipedia.org/wiki/Structural_type_system>
- <https://en.wikipedia.org/wiki/Nominal_type_system>
- <https://flow.org/en/docs/lang/nominal-structural/>
- <https://www.eclipse.org/n4js/features/nominal-and-structural-typing.html>
