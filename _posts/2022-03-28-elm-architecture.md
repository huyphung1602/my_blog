---
title: "Reading Note: The Elm Architecture"
tags: software functional elm frontend
---
  
One of the things I love about Elm is its architecture. It is simple and powerful. The Elm Architecture gives you a solid way for handling the state of your application.

The basic structure of an Elm application looks like this:

![elm-architecture](https://svgur.com/i/fhy.svg)

## Model

I already have a blog post related to Elm Model in this post [Model and Record in Elm](https://huyphung.one/posts/2022-03-27-model-and-record-in-elm/)

In short, model **contains all of your application states**. Typically, a model is a record data type.

## View

- View is responsible for displaying a model.
- The Elm Architecture enforces separation of concerns by preventing the view layer from storing state. So, in view, we use one or many stateless functions.
- The view is the visualization of the model and nothing more.
- View can describe:
  - Html elements.
  - Html attributes.
  - Events such as mouse clicks, keyboard inputs.

## Update

All states are located in the model, all changes to the model have to take place in the `update` function.

The `update` function takes two arguments:

- A `message`. The message works the same as an instruction. The `update` function needs to interpret the message to determine how to create a new state.
- The `model`

The `update` function is responsible for interpreting the message to change the state. The data types in Elm are **immutable**. So, the `update` function must return a new instance of the model with the changed state.

## Runtime

- The program contains the **runtime**.
- The `main` function is a program that gets initialized with `model`, `view`, and `update`.
- The program executes a continuous loop, taking in actions from the user, changing the state, and representing the changes in the view.
- The runtime also handles all the **effects** that your application produces or reacts to. Examples of effects:
  - Loading or Sending data via AJAX.
  - Writing to the local storage.
  - Websocket communication.

I wrote a post related to [Virtual DOM in Elm](https://huyphung.one/posts/2022-03-26-virtual-dom-in-elm/). This post mentions the model, view, update, and runtime interaction.

## Some personal thoughts

There are a lot of reasons to love Elm Architecture. For me:

- It is easy to understand.
- The update function must return a new instance when changing state. We can have a time travel debugger. You can check it here: [elm-time-travel](https://package.elm-lang.org/packages/savardd/elm-time-travel/latest/).
- It is easy to read other codes because the basic structure of every Elm application is the same.

One of my big dislikes is that I am hard to integrate other UI stuff into my application. Maybe I will have a more detailed post related to this issue later.

## References

- [Programming Elm](https://pragprog.com/titles/jfelm/programming-elm/)
- <https://dennisreimann.de/articles/elm-architecture-overview.html>
