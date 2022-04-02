---
title: "Reading Note: Interacting with time in elm"
tags: software elm frontend
---


There are two ways to interact with time in Elm.

- Via the command ("let me know when so much time has elapsed")
- Via the subscription ("let me know every time this interval has elapsed")

To understand the **command** and **subscription** in Elm I recommend you to read the [Elm documentation](https://guide.elm-lang.org/effects/) and this [article](https://lucamug.medium.com/commands-and-subscriptions-in-elm-9ff506e75d2d) at first. Moreover, you also have to learn the usages of [Process](https://package.elm-lang.org/packages/elm/core/latest/Process) and [Task](https://package.elm-lang.org/packages/elm/core/latest/Task) in Elm.

## Via a command

A **command** is a way of telling Elm, "Hey, I want you to do this thing!". So, if you want to send an HTTP request, you would need to command Elm to do it. Or if you wanted to ask for geolocation, you would need to command Elm to go get it.

We can use the command in Elm to count down the time and notify us after the timer is expired. For example:

```elm
type Model
  = Initial
  | InProgress
  | Expired

init : () -> (Model, Cmd Msg)
init _ =
  (Initial, Cmd.none)

type Msg
  = StartTimer
  | TimeIsUp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartTimer ->
      (InProgress, notifyIn TimeIsUp 5000)
    TimeIsUp ->
      case model of
        InProgress ->
          (Expired, Cmd.none)
        _ ->
          (model, Cmd.none)

notifyIn : Msg -> Float -> Cmd Msg
notifyIn msg time =
  Process.sleep time |> Task.attempt (\_ -> msg)
```

In the code above, the important part is:

```elm
StartTimer ->
  (InProgress, notifyIn TimeIsUp 5000)
```

This code switches the model from the `Initial` state to the `InProgress` state. The command kick off a timer which will notify us of the **TimeIsUp** message after 5 seconds have passed.

```elm
notifyIn : Msg -> Float -> Cmd Msg
notifyIn msg time =
  Process.sleep time |> Task.attempt (\_ -> msg)
```

## Via Subscription

A **subscription** is a way of telling Elm, "Hey, let me know if anything interesting happens over there!". So, if you want to listen for messages on a web socket, you would tell Elm to create a subscription.

In this case, you would like Elm to get the clock ticks.

```elm
type Model
  = Initial
  | InProgress
  | Expired

init : () -> (Model, Cmd Msg)
init _ =
  (Initial, Cmd.none)

type Msg
  = StartTimer
  | Tick

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartTimer ->
      (InProgress, Cmd.none)
    Tick ->
      case model of
        InProgress 1 ->
          (Expired, Cmd.none)
        InProgress x ->
          (InProgress (x - 1), Cmd.none)
        _ ->
          (model, Cmd.none)

notifyIn : Msg -> Float -> Cmd Msg
notifyIn msg time =
  Process.sleep time |> Task.attempt (\_ -> msg)

subscriptions : Model -> Sub Msg
subscriptions model =
  case model of
    Initial -> Sub.none
    InProgress _ -> Time.every 1000 (\_ -> Tick)
    Expired -> Sub.none
```

The `subscription` function triggers a `Tick` message every second when the game is in the `InProgress` state

```elm
subscription : model -> Sub Msg
  case model of
    Initial -> Sub.none
    InProgress _ -> Time.every 1000 (\_ -> Tick)
    Expired -> Sub.none
```

## References

- <https://discourse.elm-lang.org/t/how-can-i-create-a-timer-and-reset-after-the-time-is-up/6870/3>
- <https://lucamug.medium.com/commands-and-subscriptions-in-elm-9ff506e75d2d>
- <https://guide.elm-lang.org/effects/>
- <https://package.elm-lang.org/packages/elm/core/latest/Process>
- <https://package.elm-lang.org/packages/elm/core/latest/Task>
