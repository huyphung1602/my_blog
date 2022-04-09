---
title: "Reading Note: Randomness in Elm"
tags: software functional elm frontend
---

In `JavaScript`, we use `Math.random` to produce random numbers. It does not expect a seed.

Elm is compiled to `JavaScript`. However, elm does not use the native implementation for random number generation.

## Generators

The generators are behind all the randomness in Elm.

- A generator is a type.
- A generator describes how to produce random values.

Let's create a generator that describes how to produce a random integer from 0 to 3.

```elm
> Random.int 0 3
Generator <function> : Random.Generator Int

-- Let try to wrap it in a function
> zeroToThreeGenerator : Random.Generator Int
| zeroToThreeGenerator =
|   Random.int 0 3
Generator <function> : Random.Generator Int
```

Now, imagine that I would like to randomly select an item from a list. For example, you are creating a game where your hero has to select a random weapon in his weapon list. (Do you know [Kite](https://hunterxhunter.fandom.com/wiki/Kite) in Hunter x Hunter?)

```elm
type Weapon
    = Sword
    | Cannon
    | Scythe
    | Knife

numToWeapon : Int -> Weapon
numToWeapon num =
    case num of
        0 ->
            Sword
        1 ->
            Cannon
        2 ->
            Scythe
        _ ->
            Knife

weaponGenerator : Random.Generator Weapon
weaponGenerator =
    Random.map numToWeapon (Random.int 0 3)

-- type of weaponGenerator
Generator <function> : Random.Generator Weapon
```

When we typed these codes in `elm repl` because they are the generators, they cannot produce the values directly.

## Produce the values

There are two main approaches to generating random numbers:

- True Random Number Generators (TRNGs)
- Pseudo-Random Number Generators (PRNGs)

TRNGs take a longer time to generate random numbers because they generate the numbers from truly random physical phenomena (atmospheric noise picked up by radio).

PRNGs take an initial value (called seed) and apply an algorithm to generate a seemingly random number.

## Generating random numbers without seed

We could not produce the random values with side effects directly in `elm repl`. Let's look at this random weapon application I wrote: [RandomWeaponWithoutSeed](https://ellie-app.com/h9GHr7WF6x4a1)

In this example, I use `Random.generate` to produce the values.

```elm
type Msg
    = GenerateRandomWeapon
    | NewRandomWeapon Weapon


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateRandomWeapon ->
            ( model, Random.generate NewRandomWeapon weaponGenerator )

        NewRandomWeapon weapon ->
            ( weapon, Cmd.none )
-- END:update
```

It relies on [real-time clock](https://en.wikipedia.org/wiki/Real-time_clock) behind the scenes. So, it will not be efficient randomness if you run this command multiple times consecutively. It is a risk of getting the same value from running `Random.generate` multiple times consecutively.

### Generating random numbers with seed

Let's create a seed:

```elm
> Random.initialSeed
<function> : Int -> Random.Seed

> seed0 = Random.initialSeed 132132
Seed 2090120966 1013904223 : Random.Seed
```

`elm/random` provides us `Random.step`. Each time we call `Random.step` we need to provide a generator and a seed. This will produce a tuple containing a random value and a **new seed** to use if we want to run other generators later.

```elm
> Random.step
<function> : Random.Generator a -> Random.Seed -> ( a, Random.Seed )
```

Now, we could use the `Random.step` function to generate a random value.

```elm
> Random.step weaponGenerator seed0
(Knife,Seed 2961089197 1013904223)
    : ( Weapon, Random.Seed )
```

Let's add a `seedGenerator` to our previous application:

```elm
seedGenerator : Random.Generator Random.Seed
seedGenerator =
    Random.int Random.minInt Random.maxInt
        |> Random.map (Random.initialSeed)
```

Then, we add seed into the model. In the beginning, there is no seed, so I use the `Maybe Random.Seed` type for this one.

```elm
type alias Model =
    { seed : Maybe Random.Seed
    , weapon : Weapon
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( { seed = Nothing
    , weapon = Sword
    }
    , Random.generate UpdateSeed seedGenerator
    )
```

Because we define the seed type as `Maybe Random.Seed`. So, we need to use [Maybe.map](https://package.elm-lang.org/packages/elm-lang/core/5.0.0/Maybe#map) and [Maybe.withDefault](https://package.elm-lang.org/packages/elm-lang/core/5.0.0/Maybe#withDefault) in the update function to step the value.

```elm
type Msg
    = UpdateSeed Random.Seed
    | PutRandomWeapon

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateSeed seed ->
            ( { model | seed = Just seed }
            , Cmd.none
            )
        PutRandomWeapon ->
            let
                newModel : Model
                newModel =
                    model.seed
                        |> Maybe.map (Random.step weaponGenerator)
                        |> Maybe.map
                            (\(randWeapon, seed) ->
                                { model | seed = Just seed, weapon = randWeapon }
                            )
                        |> Maybe.withDefault model
            in
            (newModel, Cmd.none)
```

Let's check this new approach:

- In the initial run, we generate a random seed base on `Time.now`.
- Then, this initial seed is used to generate the first random weapon.
- At the same time, the `Random.step` also creates the **new seed** for the next step.
- When we click generate button again, the **new seed** is used to generate the new random weapon.

This will resolve the problem when using `Random.generate` to produce the random values. For the full source code please check this: [RandomWeaponWithSeed](https://ellie-app.com/h9HzDZqcLNva1)

## In short

- A **generator** is a type that describes how to produce random values. It does not produce the random value.
- Using `Random.generate` will cause side effects because it generates the seed by [real-time clock](https://en.wikipedia.org/wiki/Real-time_clock) embedded in our computer.
- It is a risk of getting the same value from running `Random.generate` multiple times consecutively. This issue could be resolved by using `Random.generate` combined with `Random.step`.

## Reference

- <https://hub.packtpub.com/random-value-generators-elm/>
- <https://elmprogramming.com/commands.html>
- <https://ckoster22.medium.com/randomness-in-elm-8e977457bf1b>
