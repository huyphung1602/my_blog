---
title: "Reading Note: Pixel and Rem"
tags: software css frontend
---

When working with the CSS stuff, I want to understand **Pixel** and **Rem**. So, I try to dig deeper into these two.

**Em** is a more complicated topic (including the media queries). I determine to mention it later. (after I comprehend it)

## Pixel

Pixel is an absolute length.

Pixel does not mean the literal screen pixels in the display you are looking at. It's [an angular measurement](http://inamidst.com/stuff/notes/csspx). So, the size of a pixel isn't always the same on different displays.

Pixel is easy to transfer from the design to the web design because the Designers typically work in pixels.

If you are setting all of your font-sizes, element sizes, and spacing in pixels, **you are not treating the end-user with respect**.

The reason is the default browser font-size could be different from the default font-size of your application (typically 16px). If the user sets the default font-size to 20px, all font sizes should scale accordingly.

## Rem

Rem is a font-relative length.

Rem is a way of setting font-sizes based on the font-size of the root HTML element. Rem allows you to quickly scale an entire project by changing the root font-size.

Calculating `px` from `rem`. For example, the html font-size is set to 10px, paragraph is set to 1.6rem. It means the paragragh font-size would be: `1.6rem * 10px = 16px`.

However, setting the base font-size in pixels still has the same problem as using the pixel. So, the solution is **setting the root HTML font-size as a percentage.** The ideal scenario would be to leave the HTML font-size at 100% (it means the HTML font-size will be equal to the default browser font-size).

## References

- <https://engageinteractive.co.uk/blog/em-vs-rem-vs-px>
- <https://css-tricks.com/the-lengths-of-css/>
