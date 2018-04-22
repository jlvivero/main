---
title: Setting up docpad on chromeos
layout: post
timestamp: 1524406611
tags:
 - docpad
 - Software Developing
 - Learning
 - chromeos
 - tinkering
---

This post is my attempt to setup docpad on chromeos without using developer mode, or any kind of dual boot, just using the default software settings from ChromeOS.
Now the truth is I started by following a guide on how to setup termux and ssh into it from Kenneth White which you can find here:
https://blog.lessonslearned.org/building-a-more-secure-development-chromebook/#ampshare=https://blog.lessonslearned.org/building-a-more-secure-development-chromebook/

So I didn't follow all the "Security" concerns the guide gave and focused more on getting a development environment working without the need to use cruton or dual booting of any kind (specially considering I'm using a cheap 200 dlls laptop, getting a full blown linux distro might be a little bit too heavy, I could always go for the lower speced linux distributions but honestly I don't like how they look/feel and chromeos looks nice without feeling too heavy).


So after following said guide I began my adventure in setting up docpad. So the first thing is that my docpad setup is probably very very outdated. It was already kinda old when I originally set it up and now it's well... way older, now my default nodejs installation is node 8.11.1, I believe I was using 0.12.13 on my first original setup, so we'll start by changing that.

There are several things in the package.json that are either outdated or jsut plain wrong nowadayas. so let's look at the original version:

```json
{
  "name": "JL's Bizzare Adventures",
  "version": "0.1.0",
  "description": "github page to show projects and blog",
  "engines": {
    "node": "0.12.13",
    "npm": "3.10.3"
  },
  "dependencies": {
    "docpad": "~6.78.6",
    "docpad-plugin-coffeescript": "~2.5.0",
    "docpad-plugin-ghpages": "~2.4.4",
    "docpad-plugin-jade": "~2.10.0",
    "docpad-plugin-marked": "~2.3.0",
    "docpad-plugin-nodesass": "~2.8.2",
    "docpad-plugin-tagcloud": "~2.0.1",
    "docpad-plugin-tags": "~2.0.7",
    "moment": "^2.10.3"
  },
  "main": "node_modules/docpad/bin/docpad-server",
  "scripts": {
    "start": "node_modules/docpad/bin/docpad-server"
  },
  "devDependencies": {}
}

```

The first thing to notice is actually not the nodejs version but the name, I'm pretty sure you can't have spaces and capital letters on name anymore ( I don't think you ever really could, but maybe it used to ignore it)

now we can start with the nodejs version, man 0.12.13, that was a long time ago, npm version should also change, my current npm version is 5.6.0. Now usually I don't change things like that cause it might break all my dependencies, but given that I'm using termux to setup everything, I don't have the luxury of using nvm so I have to work with my current node version for now.

That means that I have to go through all my dependencies and make sure they work. So the first thing to do is install docpad on my machine I did this by running
 
```shell
npm install -g npm
npm install -g docpad
```

after that and running docpad -V I realize that the current version I got was 6.79.4, okay that means that there hasn't been a huge versioning change, that's good news. Still I have to be careful, I don't know if any of the majro dependencies changed. I'm also gonna get rid of the "devDependencies" since theyr'e empty.

With that I have the following package.json:

```json
{
  "name": "jl's-bizzare-adventures",
  "version": "0.1.0",
  "description": "github page to show projects and blog",
  "engines": {
    "node": "8.11.1",
    "npm": "5.8.0"
  },
  "dependencies": {
    "docpad": "~6.79.4",
    "docpad-plugin-coffeescript": "~2.5.0",
    "docpad-plugin-ghpages": "~2.4.4",
    "docpad-plugin-jade": "~2.10.0",
    "docpad-plugin-marked": "~2.3.0",
    "docpad-plugin-nodesass": "~2.8.2",
    "docpad-plugin-tagcloud": "~2.0.1",
    "docpad-plugin-tags": "~2.0.7",
    "moment": "^2.10.3"
  },
  "main": "node_modules/docpad/bin/docpad-server",
  "scripts": {
    "start": "node_modules/docpad/bin/docpad-server"
  }
}
```

Now I'll forgo the possible dependencies problem a little bit and go to the process. Since I'm using caret as text editor, I do not have access to the termux files where I can deploy things, so I cannot deploy my modifications (because termux can access and read files from outside, but doesn't have permissions to run things there).

So how do I solve this problem?

I have a few options, the first I can think of is editing the files individually and moving them to the deployed part, this is fine and it might work nicely for single blog posts. But if I ever want to re-design the layout it'll cause a lot of problems, editing multiple files at the same time etc.

Which leads me to my second option, making use of git, I already have my blogpost on github, so why not have two repos, one for modifying one for deploying. once I made the modifications I want I can just push to github and pull from my termux environment. Now the problem with that is that I'm running a 200 dlls chromebook that has very little space, so I don't want to just clone repos left and right, but in this case, I'll bite the bullet; I can just delete the outside repo after I'm done modifying it and to be honest I don't do blogpost everyday so a once in a while clone will not hurt If I delete it after I'm done.

So both approaches have their ups and downs and  I'm personally going for the second one, just because I've been meaning to modify the layout of my blog a bit, and just thinking about constantly moving files sounds annoying.

So I'm about to push the changes and pull from my termux env, If this work I'll post the results, if it doesn't I'll write about fixing dependencies, let's see what happens! I'll see you on the other side.