---
title: Creating a blog with DocPad and GitHub Pages
layout: post
timestamp: 1402969136
tags:
 - DocPad
 - Blog
 - CoffeeScript
---

Introduction
------------

When I tried to find a static site generator to create a dev blog, the first platform I found was [Jekyll](http://jekyllrb.com/). Yes, it's a great platform and you can do everything you can imagine with the static site generator. However, I'm personally not really into Ruby. I wanted to find a Node way to do that. Eventually I found [DocPad](http://docpad.org/) and I think it's the best platform to create a static blog in the Node way.

In this article, I'll cover how to create a blog with DocPad with real-life code examples. When you finish reading this article, you'll already have a simple blog built with [DocPad](http://docpad.org/) on [GitHub Pages](https://pages.github.com/).

DocPad
------

DocPad is a static site generator built with CoffeeScript. It means that you can use all of NPM packages with it. Moreover, DocPad also has its own plugin environment, which is powered by NPM though. With the plugins, you can easily pipeline assets or resources and deploy a site to several platforms. Basically you can find the most of the plugins [here](http://docpad.org/docs/plugins).

Getting Started with DocPad
---------------------------

First of all, you should have the recent version of [Node.js](http://nodejs.org/) installed in your environment. Currently DocPad recommends installing Node.js v0.10. If you already installed a proper Node.js in your machine, you can install the DocPad with `npm`.

```shell
$ npm install -g npm # Update NPM
$ npm install -g docpad
```

When the installation finishes, you're ready to go with DocPad!

Let's make a new DocPad project. Let me name the project as `docpad-blog-example`.

```shell
$ mkdir docpad-blog-example
$ cd docpad-blog-example
$ docpad run
```

Then you'll see a dialog like this in the shell:

```
Which skeleton will you use? [1-20]
  1.    HTML5 Boilerplate
  2.    HTML5 Boilerplate with Grunt
  3.    HTML5 Boilerplate with Jade and LESS
  4.    Twitter Bootstrap
  5.    Twitter Bootstrap with Jade
  6.    Twitter Bootstrap with Coffeekup
  7.    Kitchensink
  8.    Benjamin Lupton's Website
  9.    DocPad's Website
  10.   Bevry's Website
  11.   Startup Hostel's Website
  12.   NodeChat
  13.   SlidePad
  14.   Reveal.js
  15.   Conference Boilerplate
  16.   Zurb Foundation(SASS)
  17.   Meny
  18.   YUI PureCSS
  19.   Zurb Foundation
  20.   No Skeleton
>
```

*Skeleton* is like a basic structure of a DocPad project. DocPad provides several skeletons to help users boilerplate a project easily. You can find the skeletons [here](http://docpad.org/docs/skeletons). In this article, we'll build a site from scratch. To select `No Skeleton`, enter `20`.

Then it automatically install all dependencies, build a basic structure of a site and run a development server.

```
info: DocPad listening to http://0.0.0.0:9778/ on directory /Users/noraesae/Works/temp/my-blog/out
```

You can open the site with the address, `http://localhost:9778`. There's not yet a page, and it'll show you `Not Found` currently. When you add a page in the project, the development server rebuilds and reruns the server automatically.

Turn off the server with `^C` and see the project directory. It may already contain the following files.

```
src
  documents
  files
  layouts
node_modules
  ...
README.md
package.json
docpad.coffee
```

The `README.md` and `package.json` files are for their well-known roles. Nothing special. You can freely edit them. The `node_modules` directory is also for its own role, containing NPM packages.

`docpad.coffee` is a configuration file for the DocPad project. You can configure DocPad itself or its plugins with this file. We may look into this file later.

The most important structure is the `src` directory. It has three subdirectories, `documents`, `files` and `layouts`. I'll explain how DocPad works with the directories in the next section.

How DocPad Works
----------------

As you can see above, there are three subdirectories in the `src`.

Let's start with `files`. Basically, files in the `files` directory is a static files, and don't need to be converted into another format. When the project is built, they'll be just moved into the result directory. For example, if you have a file, `src/files/css/main.css`, it'll be just moved to `css/main.css` in the built directory(`out` by default). You may want to place some 3rd-party libraries here like jQuery or Bootstrap.

The `documents` directory is for files which should be converted(or pipelined according to the DocPad document) into another format. The asset pipeline of DocPad works in the same way it works in Rails. If a file has an extension like `file.ext1.ext2.ext3`, it will be converted from `ext3` to `ext2`, and then from `ext2` to `ext1`. For example, `src/documents/js/main.js.coffee` will be converted from CoffeeScript to JavaScript, and then saved as `js/main.js` in the built directory. We'll cover this in the example.

If files in `documents` share the same format, we can extract it as a layout. A layout works like a template in other platforms. We'll also cover this in examples.

Add an Index Page
-----------------

It's time to move on. Let's add a page in our beautiful blog. But I'm very lazy and don't want to use raw HTML. Instead of HTML, I decided to use [Jade](http://jade-lang.com). Actually, DocPad recommends using [Eco](https://github.com/sstephenson/eco/) or [CoffeeKup](http://coffeekup.org/), but I think Jade is more common template language and good enough to use.

To use a `.html.jade` pipeline, install a [Jade plugin](https://github.com/docpad/docpad-plugin-jade/).

```shell
$ docpad install jade
```

As I said, DocPad has its own plugin environment, and you can install plugins with `docpad install`. It uses `npm` internally and automatically add the plugin to `package.json`. So when you deploy a project to another machine, you don't need to remember every installed plugin, but can just install every plugin with `npm install`.

When the installation finishes, add `index.html.jade` in `src/documents`.

```jade
// index.html.jade
doctype html
html
  head
    meta(charset='UTF-8')
    title My Blog
  body
    h1 My Blog
```

Now when you run `docpad run`, you can open the index page in `http://localhost:9778`. Also you can find the pipelined output, `index.html` in the `out` directory.

Like `.html.jade`, you may consider using `.css.scss` or `.js.coffee`. Many pipelinings are supported with several plugins, so it is worth checking the list in a [plugin page](http://docpad.org/docs/plugins).

Add Posts
----------

For our blog to work as a real blog, we need a post functionality. I love [Markdown](http://daringfireball.net/projects/markdown/), and I want to write posts in the Markdown format and make them share a same layout.

Let's add a layout for posts, `post.html.jade` into `src/layouts`. Files in the layout directory are also pipelined, so we can use the `.html.jade` format here.

```jade
// post.html.jade
doctype html
html
  head
    meta(charset='UTF-8')
    title= document.title
  body
    h1= document.title
    div.content!= content
```

As you can see in the example code, there are something different from `index.html.jade`. We refer `document.title` and `content` variables. The variables will be provided from post documents.

Now, let's add a post document. We already decided to use the Markdown format, and we need to install the Markdown plugin.

```shell
$ docpad install marked
```

When the installation finishes, make a `src/documents/posts` directory and add a document, `hello-world.html.md`, in the directory.

```markdown
---
title: Hello, World!
layout: post
---

Overview
--------

Hello, world! Please visit my [GitHub](https://github.com/) page!
```

For each post, we need to specify a title and layout. DocPad provides a way to set variables in documents between two `---`. As you can see in the example above, we set `title` and `layout` between `---`.

`layout` specifies which layout should be used. In this example, DocPad will find the `post.html` layout, which will be pipelined from `post.html.jade`.

As we can see in the previous `post.html.jade` layout, we can refer the variables with the `document` object. For example, `title` with `document.title`.

The rest part of the post document(from the second `---`) will be just pipelined and provided into the layout as the `content` variable. In the layout, the content is rendered like `div.content!= content`.

Now, when you run `docpad run` and open `http://localhost:9778/posts/hello-world.html`, you can see the post page we just created.

For test, let's create similar posts in the `src/documents/posts` directory and see how they're rendered as results.

Add a post list
---------------

We already have some posts, and now we need links to them from the index page we've made. DocPad provides helpers to query several kinds of collections. You can find the documentation for the helpers [here](http://docpad.org/docs/template-data). In the following example, we'll use a `getCollection` function to query the collection of the posts.

Let's edit the `index.html.jade` like below:

```jade
// index.html.jade
doctype html
html
  head
    meta(charset='UTF-8')
    title My Blog
  body
    h1 My Blog
    h2 Post List
    ul.posts
      each post in getCollection('html').findAll({layout: 'post'}).toJSON()
        li.post
          a(href='./#{post.url}')= post.title
```

We just added a `ul` element to show the post list. The most important part in this example is `getCollection('html').findAll({layout: 'post'}).toJSON()`. First, we call `getCollection` function with `'html'`. The actual parameter, `'html'` means the type of the collection, for example, `documents`, `files`, `layouts`, `html` and `stylesheet`. As a result, it returns a [Query-Engine](https://github.com/bevry/query-engine) collection object. After that, we call a `findAll` function with `{layout: 'post'}`, to get the list of the posts of which layout is `post`. `toJSON` function change the result, a Query-Engine object, to a JSON object, in this case, a JavaScript list. The last thing to do is just iterating through the list using each template engine's iterator.

Finally, when you run `docpad run` and open `http://localhost:9778`, you can see the list of your posts.

Add Tags
--------

For the last feature of our simple but beautiful blog, I'll add tags for each post. Tagging is an essential feature for a blog, and I think I should cover it in this article. I promise that it's not difficult at all.

Let's start with installing [tags](https://github.com/docpad/docpad-plugin-tags) plugin.

```shell
$ docpad install tags
```

When the installation finishes, add some tags in your posts. You can define a list property(`tags`) like below in your post document.

```markdown
---
title: Hello, World!
layout: post
tags:
 - Hello
 - DocPad
 - Example
---

Overview
--------

Hello, world! Please visit my [GitHub](https://github.com/) page!
```

After adding tags for other posts we've made, run `docpad generate` to rebuild your project. You can see that a `tags` directory is created in your output directory(`out` by default).

In the `out/tags` directory, there will be JSON files created automatically. However, what we want may not be JSON files, but HTML files to list the posts which have a same tag. So, we should configurate the [tags](https://github.com/docpad/docpad-plugin-tags) plugin. We'll cover some major configurations of the plugin in this article, but you can also find a documentation in the project page of the plugin.

To configurate DocPad or its plugins, we should modify `docpad.coffee`. It's DocPad configuration file, and you can set several configurations in this file. We've not modified it at all, so the content will be like below.

```coffeescript
# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
  # ...
}

# Export the DocPad Configuration
module.exports = docpadConfig
```

In the `docpadConfig` object, we'll define some configurations for the tags plugin. Modify the object like below.

```coffeescript
# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig =
  plugins:
    tags:
      extension: '.html'
      injectDocumentHelper: (doc) ->
        doc.setMeta {layout: 'tag'}

# Export the DocPad Configuration
module.exports = docpadConfig
```

It's CoffeeScript and I dropped the curly braces. First, you can see that I change the `extension` to `.html`. It'll make the tags plugin to produce the result as a HTML format. Second, I set a `injectDocumentHelper` method. It'll be called when the plugin pipelines the document files, in this case, the tag results. The method will be called with a document object and you can manipulate it as you want. For me, I add a `layout` metadata to make the tag documents use the `tag` layout.

Now, all I need to do is implementing the `tag` layout, which is defined to be used. Let's create `src/layouts/tag.html.jade`.

```jade
// tag.html.jade
doctype html
html
  head
    meta(charset='UTF-8')
    title= document.tag
  body
    h1 My Blog
    h2 Post List in #{document.tag}
    ul.posts
      each post in getCollection('html').findAll({layout: 'post', tags: {$in: document.tag}}).toJSON()
        li.post
          a(href='./#{post.url}')= post.title
```

As you can see in the example, the tag name can be accessed with `document.tag`. In addition, along with the `html` collection queried by `getCollection('html')`, you can use `$in` to check if an array property contains a value and filter the result. You can find more Query-Engine documentation [here](http://learn.bevry.me/queryengine/guide).

Now when you run `docpad run` and open `http://localhost:9778/tags/hello.html` in a browser, you can see the list of posts which have a `Hello` tag.

However, it's meaningless if there's no link to the tag pages. Finally, we'll add a tag list to the main page. Let's edit the `src/documents/index.html.jade` file.

```jade
// index.html.jade
doctype html
html
  head
    meta(charset='UTF-8')
    title My Blog
  body
    h1 My Blog
    h2 Post List
    ul.posts
      each post in getCollection('html').findAll({layout: 'post'}).toJSON()
        li.post
          a(href='./#{post.url}')= post.title
    h2 Tag List
    ul.tags
      each tag in getFilesAtPath('tags/').toJSON()
        li.tag
          a(href='./#{tag.url}')= tag.title
```

To list the tags up, I used a `getFilesAtPath` function which just list all files in a given directory. You can also get a title and url from the tag files. Now when you run `docpad run` and open `http://localhost:9778/`, you can see the tag list.

Until now, we've implemented a simple tag functionality in our blog. You also can have the option to use a [TagCloud](https://github.com/rantecki/docpad-plugin-tagcloud) plugin. It helps you get the list of the tags easily and also provides a weight for each tag. It worths checking it out.

Deploy
------

I think now we're ready to deploy our simple but beautiful blog to the internet world. [GitHub Pages](https://pages.github.com) is the best platform to deploy a static site. You can serve static results of our blog while keeping the source in its repository. In this article, we won't cover [Git](http://git-scm.com/) and [GitHub](https://github.com/). If you're not familiar with them, please please just use them. They're awesome and well-documented so that you can learn them by yourself.

Before deploying the source to a Git repository, I recommend making `.gitignore` containing following items in it.

```
/node_modules
/out
```

`/node_modules` will contain NPM packages, but we don't need to include it in our Git repository because it can be installed automatically with `npm install`. `/out` is a directory which will contain the compiled result of DocPad by default. It's just a result from the original source, and our repository doesn't need to include it. Please create a proper `.gitignore` file as you want.

To deploy the source to GitHub Pages, we need a repository. I created a `docpad-blog-example` repository on [GitHub](https://github.com/noraesae/docpad-blog-example), and let's deploy the source to it.

```shell
$ git init
$ git add .
$ git commit -m "Initial commit."
$ git remote add origin git@github.com:noraesae/docpad-blog-example.git
$ git push -u origin master
```

Now, we just uploaded our source to the GitHub repository, but it doesn't mean that we can use GitHub Pages. To use GitHub Pages, we should create a `origin/gh-pages` branch which contains static files. So first, we should compile our source, move the result to a new clean branch and push the branch to `origin/gh-pages`. It's quite complicated(at least, to me) and I'll just stick to a convenient way, a `ghpages` DocPad plugin.

```shell
$ docpad install ghpages
```

The [ghpages](https://github.com/docpad/docpad-plugin-ghpages) plugin helps us deploy our static site to GitHub Pages. Note that the shell command will update `package.json` and we're working on a Git repository. It means that we shouldn't forget to commit the change of the `package.json`.

After the installation finishes, all you need to do is just running the following command.

```shell
$ docpad deploy-ghpages --env static
```

It'll automatically generate the static site and deploy it to the `origin/gh-pages` branch. Now you can see your blog on [GitHub Pages](noraesae.github.io/docpad-blog-example) in some minutes!

In GitHub Pages, a static site is served as a URL, `http://username.github.io/repository` by default. However, GitHub Pages also provides a functionality to set a custom domain. You can find information in this [article](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages). It's pretty easy and there may be no problem to use GitHub Pages as a personal blog!

Conclusion
----------

We've covered the basic functionalities of DocPad and now we have a simple blog powered by it. Using more CSS and JavaScript files, you can create more awesome and fully-featured blog as well.

Actually, this blog is also running in the exact same way. You can find the source code of this blog [here](https://github.com/noraesae/net). By looking into commit logs and changes, you can find how I've implemented something or resolved some problems. Every work we've done in this article is also uploaded in [a GitHub repository](https://github.com/noraesae/docpad-blog-example). You can find out how it really works in its [GitHub Pages](http://noraesae.github.io/docpad-blog-example/).

I will be really happy if this article helps developers who love Node.js(JavaScript and CoffeeScript) create their wonderful blogs.

### Excuse my English
I just started writing blog posts in English, and there'll be a lot of mistakes in grammar or expression. I'll be *really* happy if you help me to improve this post. You can leave any comment [here](https://github.com/noraesae/net/issues/4) to help me. Thanks in advance.
