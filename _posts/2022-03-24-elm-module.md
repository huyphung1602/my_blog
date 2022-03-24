---
title: "Reading Note: Elm module"
tags: software functional elm
---

## Elm Module

- Every Elm file is a module.
- Modules organize the code into logical units.
- Each module contains one or more constants and functions that it can expose to the other modules.
- Elm needs the main module to compile your application into a JavaScript or HTML file for the browser.

A simple main module in Elm:

```elm
module Main exposing (main)
import Html exposing (Html, text)

main : Html msg
main =
  text "Hello, Elm"
```

The **main constant name is important** but not the module's name. You could call your main module name Greenday.

```elm
module Greenday exposing (main)
```

However, if you change the name of the main constant. Elm will raise an error when you build your main module.

```elm
module Greenday exposing (wakeMeUpWhenSeptemperEnd)
import Html exposing (Html, text)

wakeMeUpWhenSeptemperEnd : Html msg
wakeMeUpWhenSeptemperEnd =
  text "Hello, Elm"
```

Try the code above and see what happens.

## Small quiz

You could see that the type annotation of our main module is `Html msg`. Why?
