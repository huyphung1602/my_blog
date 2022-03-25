---
title: "Reading Note: Virtual DOM in Elm"
tags: software functional elm frontend
---

Yesterday, I read about the Virtual DOM in Elm. As a backend developer by default, I am curious about this topic and want to learn more about why there is something called Virtual DOM.

## What is DOM?

The Document Object Model (DOM) is the data representation of the objects that comprise the structure and content of a document on the web.

- DOM is a programming interface for web documents.
- DOM representation allows it to be manipulated (structure, style, and content).
- The DOM represents the document as nodes and objects. In that way, programming languages can interact with the page.
- The HTML DOM is tree-structured.

![example-dom-tree](https://developer.mozilla.org/en-US/docs/Web/API/HTML_DOM_API/dom-structure.svg)

## How are DOM updates rendered on the screen?

When we do:

```javascript
document.getElementById('elementId').innerHTML = "New Value";
```

The following things happen:

1. Browser lexical analysis HTML.
2. Delete the child elements of the element.
3. Update the DOM with the new value.
4. Recalculate CSS for parent and child elements.
5. Accurately coordinate and update the layout.
6. Traverse the entire render tree and draw in the browser.

## The problems of DOM updates

Updating the DOM by manipulating it has the two problems:

- It's hard to manage. Imagine you have to tweak an event handler. We have to dive deep into the code to know what is going on when we lost the context. It is time-consuming and bug risky.
- It's inefficient. We have to find things manually.

## Virtual DOM in Elm

Virtual DOM is an in-memory representation of Real DOM. It is a lightweight JavaScript object which is a copy of the Real DOM.
The next part will describe the Virtual DOM in Elm. You have to be familiar with the basic concepts (Model, Update, View) of [The Elm Architechture](https://guide.elm-lang.org/architecture/)

In **Elm**, the `view` function with the `initialModel` produce a virtual DOM representation of HTML we want to display. Elm interprets the virtual DOM and renders the correct HTML in the browser.

![virtual-dom-to-html-elm](https://i.imgur.com/8Ab4zcl.png)

Imagine that we have a button with the event function `onClick` which mapped to a `ButtonClick` message in the `update` function.

Elm reads through the returned virtual DOM and encounters the event attribute, using the DOM API to wire up a click handler from the button's DOM node. When we click the button, the click handler will dispatch the `ButtonClick` message to queue in Elm runtime.

The Elm runtime will pick the message from the queue and call our update function with the message and current model. The update function will use the `case` expression to return the new model with new changes.

![elm-message-queue-update](https://i.imgur.com/KDeFA1m.png)

The Elm runtime then calls your view function on the new model to retrieve a new virtual DOM representation. Elm compares the current virtual DOM with the new virtual DOM and computes a **diff**. Elm creates a list of **patches** to apply to the real DOM in order to make it reflect the new virtual DOM. The **diff** and **patches** give our application better performance because they help Elm runtime avoid rendering the entire application. Instead, Elm runtime adds, removes, and replaces DOM nodes **only where necessary**.

![elm-virtual-dom-update](https://i.imgur.com/WrbUZJ9.png)

## References

- [Programming Elm](https://pragprog.com/titles/jfelm/programming-elm/)
- <https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction>
- <https://blog.fearcat.in/a?ID=01500-f3385d05-62df-4868-a6ea-85c750c0fc9d>
- <https://reactkungfu.com/2015/10/the-difference-between-virtual-dom-and-dom/>
- <https://www.tezify.com/post/what-is-virtual-dom-and-what-problem-does-it-solve/>
