---
title: Call, Apply and Bind in JavaScript
layout: post
timestamp: 1399935838
tags:
 - JavaScript
---

Overview
--------

In JavaScript, there are some methods which help developers use or manipulate a function in a convenient way. They're `call`, `apply` and `bind`. This post will cover what they do and how to use them.

Function
--------

Okay, I admit that I already talked about *function* in the previous post. But we should mention the *function* again before looking into `call`, `apply` and `bind`, because they are the methods of the *function* and do something with the *function*.

The first thing we should know about *function* is `this`, a *receiver* of a *function*. The *receiver* is decided when the *function* is called. Commonly, a method's *receiver* is an object which has the method.

```javascript
var graham = {
  name: 'Graham',
  sayHello: function () {
    console.log('Hello, ' + this.name + '!');
  }
};

graham.sayHello(); // prints 'Hello, Graham!'
```

For non-method functions, `this` refers several things in different contexts.

```javascript
var example = function () {
  return this;
};

example(); // global object.
example().a = 10; // *polluting the global!*
console.log(a); // 10

var strictExample = function () {
  'use strict';
  return this;
};

strictExample(); // undefined

var ConstructorExample = function () {
  console.log(this);
};

var obj = new ConstructorExample(); // {}
```

Briefly, `this` in a normal function refers the `global` object. If it's in [strict mode](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/Strict_mode), `this` will be `undefined`. If the function is used with the `new` operator, a new empty object will be assigned to `this`.

And the second thing we should know is `arguments`. In every function, `arguments` refers an array-like object of arguments provided to the function.

```javascript
var example = function () {
  return arguments;
};

var a = example(2014, 'Hello', {});
a.length; // 3
a[0]; // 2014
a[1]; // 'Hello'
a[2]; // {}
a instanceof Array; // false
a.forEach; // undefined
```

As the example above shows, `arguments` in a function contains all arguments provided to the function. It has a `length` property and arguments in their index, but it's not an `Array` object and doesn't have array methods in itself. You can find more information [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/arguments).


They're quite simple, and let's move onto the main topic now.

Call
----

Imagine that you implemented an awesome array-like object. The object has a `length` property and indexed elements.

```javascript
var awesome = {
  0: 'Hello',
  1: 'I am',
  2: '*awesome*',
  length: 3
};
```

And you wanted to iterate through this object, so you decided to use a `forEach` method. But can we call the `forEach` method with the object?

```javascript
awesome.forEach(console.log);
// TypeError: Object #<Object> has no method 'forEach'
```

No, we can't. The object doesn't have a `forEach` method. But you're a lazy developer and really don't want to implement it. Then, you can use the `call` method.

```javascript
Array.prototype.forEach.call(awesome, console.log);
// Hello
// I am
// *awesome*
```

The syntax of the `call` method is like below:

```
function.prototype.call(thisArg[, arg1[, arg2[, ...]]])
```

It takes `thisArg`, or a *receiver* of the function, as its first argument. It means that you can make any object work as the *receiver*. In our example of `awesome`, we give `awesome` for the `call` method's first parameter. So, `Array.prototype.forEach` function works with `awesome` as if it's an `Array` object. You can also give different number of parameters to the `call` method, and the function will work as if the parameters are provided to the original function.

Apply
-----

Now we can use the `call` method very well. Now imagine that you implemented another awesome function which prints the maximum value of every parameter provided to itself. And again, you're very lazy and want to use `Math.max` method to get the maximum value. If the function takes exact 3 arguments, it will be like below.

```javascript
var printMax = function (a, b, c) {
  console.log(Math.max(a, b, c));
};
printMax(10, 20, 30000); // prints 30000
```

But what if we want `printMax` to work with any number of parameters? We already know that `arguments` object in a function refers a list of arguments provided to the function. Let's use `arguments` in `printMax` function.

```javascript
var printMax = function () {
  console.log(Math.max(arguments));
};
printMax(10, 20, 30000); // prints NaN
```

Oh, something goes very wrong. It prints `NaN`, the most unwanted result. It's because `Math.max` doesn't take an `Array`, or an array-like object, as its paramter. `apply` method is for this kind of situation.

```javascript
var printMax = function () {
  console.log(Math.max.apply(null, arguments));
};
printMax(10, 20, 30000); // prints 30000, yeeeeeees!
```

`apply` is basically similar to `call`, but has one difference. It takes a list of arguments as its second parameter. The syntax of the `apply` method is like below.

```
function.prototype.apply(thisArg, [argsArray])
```

So when you want to pass a list of arguments to a function which doesn't take an array, you can go with the `apply` method. As described above, if you want to change `this` of the function, you can just pass a new `this` object as the first parameter of `apply`.

Bind
----

Let's return to the `awesome` object we created above.

```javascript
var awesome = {
  0: 'Hello',
  1: 'I am',
  2: '*awesome*',
  length: 3
};
Array.prototype.forEach.call(awesome, console.log);
```

You're very happy with the result, but now you want the `forEach` to be called as a callback of another function, `loadSomething`. For sure, you can do it like below.

```javascript
loadSomething(function () { // callback
  Array.prototype.forEach.call(awesome, console.log);
});
```

But, you know, you're very lazy. You don't want to create a new anonymous function. But you can't do it like below.

```javascript
loadSomething(Array.prototype.forEach.call(awesome, console.log));
```

Because when the `call` method is called, it means that the function is already done. We can use `bind` method in this case.

```javascript
loadSomething(Array.prototype.forEach.bind(awesome, console.log));
```

`bind` has a very similar syntax to `call`, except that it doesn't call the function instantly, but returns a new function with a new *receiver* and parameters. The syntax of the `bind` method is like below.

```
function.prototype.bind(thisArg[, arg1[, arg2[, ...]]])
```

Power of the `bind` method is that you can pass only part of arguments to the function, and create a new function with some fixed arguments.

```javascript
var sum = function (a, b, c) {
  return a + b + c;
};
sum(10, 20, 30); // 60

var newSum1 = sum.bind(null, 300);
/*
newSum1 works in the exact same way with a function below.
function (b, c) {
  return 300 + b + c;
};
*/
newSum1(20, 30); // 350

var newSum2 = sum.bind(null, 300, 400);
/*
newSum2 works in the exact same way with a function below.
function (c) {
  return 300 + 400 + c;
};
*/
newSum2(30); // 730
```

So, with `bind`, you can create a new function with not only a new `receiver`, but also some fixed arguments.

References
----------

You can get more information from Mozilla Developer Network about [call](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call), [apply](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply), and [bind](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind). And also I strongly recommend every JavaScript developer to read [Effective JavaScript](http://effectivejs.com/). Everything in this post is covered by the book.

### Excuse my English
I just started writing blog posts in English, and there'll be a lot of mistakes in grammar or expression. I'll be *really* happy if you help me to improve this post. You can leave any comment [here](https://github.com/noraesae/net/issues/2) to help me. Thanks in advance.
