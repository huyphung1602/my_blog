---
title: "My setup for an Elm application from development to production"
tags: software elm
---

## Install Elm

It is easy to install elm via this guide [Install Elm](https://guide.elm-lang.org/install/elm.html)

After installing elm, now create a folder for your application and run `elm init`

```shell
~/workspace > mkdir elm_project && cd elm_project
~/workspace > elm init
```

This command will create an elm.json file and an src/ directory:

- `elm.json` file describes your project's direct and indirect dependencies.
- `src/` hold your Elm files.

## Development

All the Elm applications start from a single file called `Main.elm`. Let's write one. You could try a simple example of a counter application here: https://guide.elm-lang.org/

## Yarn

There are many ways to manage our El project. I prefer to use `yarn` for package manager and `parcel` for bundler. There is no reason behind that, you could choose another package manager and bundler.

Now, run:

```shell
~/workspace/elm_project > yarn init
~/workspace/elm_project > yarn add parcel
```

You need to add [elm](https://yarnpkg.com/package/elm). You may also want to add:

- [elm-hot](https://yarnpkg.com/package/elm-hot) for hot code swapping for Elm
- [elm-test](https://yarnpkg.com/package/elm-test) for running tests

```shell
~/workspace/elm_project > yarn add elm
~/workspace/elm_project > yarn add elm-hot
~/workspace/elm_project > yarn add elm-test
```

## Parcel

It is time to learn how to use `parcel` for hot-loading your development on local and build the Javascript files for production.

You should want to read this one: <https://parceljs.org/languages/elm/>

In short, you will need to define an `index.html` file:

```html
<!DOCTYPE html>
<div id="root"></div>
<script type="module" src="index.js"></script>
```

And an `index.j`s file:

```javascript
import { Elm } from "./Main.elm";
Elm.Main.init({ node: document.getElementById("root") });
```

You need this to add [@parcel/transformer-elm](https://yarnpkg.com/package/@parcel/transformer-elm) to bundle the elm code.

Your `package.json` should look like the below. I changed the **source** and **scripts** properties.

```json
{
  "name": "elm_project",
  "version": "1.0.0",
  "license": "MIT",
  "source": "src/index.html",
  "dependencies": {
    "@parcel/transformer-elm": "^2.4.1",
    "elm": "^0.19.1-5",
    "elm-hot": "^1.1.6",
    "parcel": "^2.4.1"
  },
  "scripts": {
    "start": "parcel",
    "build": "parcel build"
  }
}
```

Run **yarn start** and you could develop elm on `http://localhost:1234/`

## Source control and deployment

You could use GitHub or whatever source control you love. If you use Github, you should add these files to the `.gitignore` file:

```txt
node_modules
elm-stuff
.parcel-cache
dist
yarn-error.log
```

I am deploying my elm application to <https://vercel.com/>

![https://i.imgur.com/6P7EZxh.png](https://i.imgur.com/6P7EZxh.png)

I hope the guide could help you to set up your next Elm application smoothly.
