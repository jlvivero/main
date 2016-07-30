---
title: Learning react from scratch.
layout: post
timestamp: 1469915863
tags:
 - programming
 - web-dev
 - react
 - facebook
---
I recently had to work on a project that involved making a web page from scratch. I've made backend projects several times and at least I know enough about making a web server from scratch using nodejs or any other scripting language.  

As for the front end, I had worked on a web page that was already built, where I just had to fix some javascript bugs and move some html around, but I had never done a page from scratch.

So I started trying react, and I have to say, at first it was very confusing, I understood the basic concept of dividing the page into parts or components, and while I still don't understand the inner workings of react (how it actually does it's updating) I understood that react updated its components so that whenever you change something, it redraws that part completely, making it so that the page is truly dynamic without having to mutate the html.

Anyway the basic concept was somewhat understood, but using it was still daunting. I figured the first place to try was facebook's [tutorial](https://facebook.github.io/react/docs/tutorial.html).
I started building my web page finally based on the tutorial, until I came about my first roadblock. How to actually switch components in react based on something that happens somewhere else.

In my case I had a nav-bar that had 3 buttons and I wanted to make sure the component body changed according to a click on those buttons, but I had no idea how to make the two different components communicate with each other. This is where the facebook tutorial was somewhat lacking, as it explained a case where changing components was dependent on a parent or a child component, mine was a sister component. So that meant that the specific case wasn't working for me.

So I searched stackoverflow for a similar problem and fortunately I found some interesting topics. The first one was [this stackoverflow question](http://stackoverflow.com/questions/34078033/switching-between-components-in-react-js) it only gave you a small reference on how to switch and once I saw that my mindset changed a little bit. See I was writing components as if it were html mostly, even tho I was writing in jsx, I was thinking like I was writing static html code. So I started tinkering with the buttons, but I was still missing something

### Props  

What I was missing was how props really work, and [this Stack overflow thread](http://stackoverflow.com/questions/24147331/react-the-right-way-to-pass-form-element-state-to-sibling-parent-elements) helped me understand it correctly, and conveniently for me, it had a pretty similar problem as mine, there were some differences but that was still good enough to send me on my way.

The important thing was that I started to understand how props work, and I begin to understand how the basic design of a react webpage worked, and I finally started to see react not as a messy overwhelming framework, but as a very elegant solution for programmers to be able to make webpages like you would design any other application.


*I leave here all the links that I used to learn react, I hope they're useful to anyone that needs them:*  
- https://facebook.github.io/react/docs/tutorial.html
- https://youtu.be/XxVg_s8xAms
- https://scotch.io/tutorials/learning-react-getting-started-and-concepts
- http://stackoverflow.com/questions/24147331/react-the-right-way-to-pass-form-element-state-to-sibling-parent-elements
