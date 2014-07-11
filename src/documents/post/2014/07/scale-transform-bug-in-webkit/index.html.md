---
title: Scale transform bug in WebKit
layout: post
timestamp: 1405046431
tags:
 - CSS
 - Bug
 - Workaround
---

There is a known bug in WebKit using `-webkit-transform: scale(...);` for an element in a `overflow: hidden;` container. WebKit draws the overflown area of the element while it's scaling. I found the bug when I change the hover effect in my [About](http://noraesae.net/about) page, and after googling it I found that it's a well-known bug.

Workaround
----------

Workaround for the bug is quite simple. Just add a style below for the container element.

```css
-webkit-mask-image: -webkit-radial-gradient(#ffffff, #000000);
```

You can see what's the problem and how it changes by the workaround in a [JSFiddle](http://jsfiddle.net/k9RAk/).

So...
-----

It's not a big problem and easy to bypass. However, it's quite disappointing that recently I keep finding some bugs in WebKit(or even Blink), which aren't found in Gecko. As a fan of WebKit(or Blink) browsers, I hope they're getting better soon.
