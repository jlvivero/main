---
title: Understanding OOP in JavaScript
layout: post
timestamp: 1399468881
tags:
 - JavaScript
 - OOP
---

Overview
--------

Many developers are familiar to OOP([Object Oriented Programming](http://en.wikipedia.org/wiki/Object-oriented_programming)) concept in several programming languages. The developers who usually write code in C++, Java, Python, Ruby or other class-based languages may be familiar to *class*, and some of them are surprised by the fact that there's no *class* in JavaScript and we don't use it to achieve OOP.

Yes, there's no *class* in JavaScript. Instead of *class*, we use *prototype* to achieve OOP. That's why JavaScript(or other ECMAScript implementations) is called [prototype-based](http://en.wikipedia.org/wiki/Prototype-based_programming) language. A *prototype* is shared in several objects, and it means that the objects can do the same actions, like class instances in the class-based languages.

This post will cover how to implement OOP in JavaScript and how it works internally from the basics. Many JavaScript developers may already know how to implement class-like objects in JavaScript, but it's very important to know actually how it's achieved internally.

Function
--------
Before looking into how *prototype* works, we should look into *function* in JavaScript. JavaScript is a functional programming language, and *function* do lots of thing in it. Basically, *function* does what it does in other languages, as procedure or method. But in Javascript, it's not only first-classed and higher-ordered, but also used to achieve OOP. By the fact, some developers think that *function* is *class* in JavaScript, but it's not true. As I said, there's no *class* in JavaScript. *Function* in JavaScript is more likely *constructor* than *class*. Let's look more in detail.

```javascript
var add = function (a, b) {
  return a + b;
};
add(1000, 4); // 1004
```

The example above shows that a function works as its typical role, a procedure. There's nothing special.

```javascript
var tom = {
  name: 'Tom',
  sayHello: function () {
    console.log('Hello, ' + this.name);
  }
};
tom.sayHello(); // Prints 'Hello, Tom'
```

The example above shows that a function `sayHello` works as an object method. There's a special, but very familiar symbol in the function, `this`. `this` means the *receiver* of the function, in this example, the `tom` object. What happens if we refer `this` in a function without *receiver*?

```javascript
var sayHello = function () {
  console.log('Hello, ' + this.name);
};
sayHello(); // Prints 'Hello, undefined'
```

As you can see in the example above, it does something wrong. In detail, `this` refers the global object, unless it's strict mode. If it's strict mode, it refers `undefined`. Then, can't we use `this` except for the object methods? You may have seen a code like below.

```javascript
var City = function (name, country) {
  this.name = name;
  this.country = country;
};
```

What happened to `this`? Though the function is not an object method, `this` is being used and even some variables are assigned to its properties. The example above shows how to define a *constructor*.

```javascript
City('Seoul', 'Korea');
name; // 'Seoul'
country; // 'Korea'
```

If you use `City` as a normal function, it'll try to assign `name` and `country` to the properties of `this`, or the global object, as I mentioned above. It looks weird and in fact it's very dangerous to pollute the global environment.

```javascript
var tokyo = new City('Tokyo', 'Japan');
tokyo.name; // 'Tokyo'
tokyo.country; // 'Japan'
```

But when it's used with `new` operator, a magic occurs. When a function is called with `new` operator, an empty object `{}` becomes the *receiver*, or `this`,  of the function, and the object is returned at the and of the function call without any explicit `return` statement.

This is how *function* in JavaScript works as *constructor* of objects. For sure, you can add some functions into `this`.

```javascript
var City = function (name, country) {
  this.name = name;
  this.country = country;

  this.describe = function () {
    return this.name + ' in ' + this.country;
  };
};
var seoul = new City('Seoul', 'Korea');
var tokyo = new City('Tokyo', 'Japan');
seoul.describe(); // 'Seoul in Korea'
tokyo.describe(); // 'Tokyo in Japan'
```

This looks quite simple and you may feel like good to go. But what if we want to change the way `describe` works?

```javascript
seoul.describe = function () {
  return this.name + ' is a city of ' + this.country;
};
seoul.describe(); // 'Seoul is a city of Korea'
tokyo.describe(); // 'Tokyo in Japan' *Oh no!*
```

As you can see in the example above, we can't easily change how the `describe` method works for each `City` object. It's because the method is not shared through the objects, even though they're from the same *constructor*. It doesn't make sense of OOP. How can we make the object methods shared through the objects?

Finally, here comes the *prototype*.

Prototype
---------

Now, we can start talking about *prototype*. With *prototype*, we can implement shared properties through objects from the same *constructor*. Here is an example.

```javascript
var City = function (name, country) {
  this.name = name;
  this.country = country;
};
City.prototype; // {}

City.prototype.describe = function () {
  return this.name + ' in ' + this.country;
};

var seoul = new City('Seoul', 'Korea');
var tokyo = new City('Tokyo', 'Japan');
seoul.describe(); // 'Seoul in Korea'
tokyo.describe(); // 'Tokyo in Japan'
```

With the `prototype` property, you can easily change the way an object method works.

```javascript
City.prototype.describe = function () {
  return this.name + ' is a city of ' + this.country;
};
seoul.describe(); // 'Seoul is a city of Korea'
tokyo.describe(); // 'Tokyo is a city of Japan' *Yes!*
```

Then how it works internally? How can the objects from the same *constructor* have the same properties by *prototype*?

Every function has its own `prototype` object as its property.

```javascript
var sayHello = function () {
  console.log('Hello!');
};
sayHello.prototype; // {}
String.prototype; // built-in String function, {}
```

And when an object is created with `new` operator, the `prototype` property of the *constructor* function will be set as the *prototype* of the object internally. And when a property in the object is referred, the object's own properties are looked up first, and then the *prototype* properties are looked up. Let's look into it with the specific example below.

```javascript
var Person = function (name) {
  this.name = name;
};
var alex = new Person('Alex');
// We just implemented a *constructor* function and an object from it.

Person.prototype; // {}
alex.prototype; // undefined
// `Person` is a function and has a `prototype` property.
// `alex` is an object and doesn't have a `prototype` property.
// But `alex` has `Person.prototype` as its *prototype* internally.

alex.name; // 'Alex'
alex.isHuman; // undefined
// We can access the `name` property of the `alex` object,
// because it's initialised in the *constructor* function.
// But we can't access the `isHuman` property,
// because the object doesn't have it.

Person.prototype.isHuman = true;
alex.isHuman; // true
// But if we define the `isHuman` property in `Person.prototype`,
// we can access it in the `alex` object too.

var graham = new Person('Graham');
graham.isHuman; // true
// Because the *prototype* is shared through the objects,
// the `isHuman` property can be accessed in every objects from `Person`.
```

The example above shows how a property is accessed in several objects. First, their own properties are looked up, and its *prototype* for the next. The diagram below will show the structure visually.

```
function `Person`     -------- new --------> object `alex`
    prototype: <---------- prototype ------/     name: 'Alex'
        isHuman: true                      \
                                            \object `graham`
                                                 name: 'Graham'
```

Briefly, every function has a `prototype` property, which is set as a *prototype* of the object when the function is called with the `new` operator, or as a *constructor*. The *prototype* is shared through all objects from the same *constructor*.

We can get a *prototype* object from an object by using `__proto__` or `Object.getPrototypeOf`. But you should prefer using `Object.getPrototypeOf` because `__proto__` is a bit obsolete.

```javascript
Object.getPrototypeOf(alex); // === Person.prototype
alex.__proto__; // === Person.prototype

Object.getPrototypeOf(alex).isHuman = false;
alex.isHuman; // false
graham.isHuman; // false
```

Conclusion
----------
Until now, we've covered how a function works as a *constructor* and a *prototype* is shared through several objects. The fact is quite simple, but it's very important for us to know how they really work internally. This is a very basic knowledge and many developers may already know it. But I'll be really happy if this article can be helpful for the developers who lost their way in OOP ocean of JavaScript.

### Excuse my English
I just started writing blog posts in English, and there'll be a lot of mistakes in grammar or expression. I'll be *really* happy if you help me to improve this post. You can leave any comment [here](https://github.com/noraesae/net/tree/master/src/documents/post/2014/05/understanding-oop-in-javascript/index.html.md) to help me. Thanks in advance.
