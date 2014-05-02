#!/usr/bin/env coffee

fs = require 'fs'
moment = require 'moment'
path = require 'path'
readline = require 'readline'

rl = readline.createInterface
  input: process.stdin
  output: process.stdout

converToDirNameFormat = (str) ->
  str.toLowerCase().replace(/[^a-z0-9\s]/g, ' ').trim().replace(/\s+/g, '-')

rl.question 'Post title: ', (answer) ->
  title = answer.trim()

  if not answer
    console.log 'No title.'
    process.exit 1

  postDirName = converToDirNameFormat title
  if not postDirName
    console.log 'Wrong title.'
    process.exit 1

  postRoot = path.join __dirname, 'src/documents/post'

  rl.question 'Tags (Comma-separated): ', (answer) ->
    tagString = answer.trim()
    tags = tagString.split(',').map (str) -> str.trim()
    tags = tags.filter Boolean # To remove empty string

    if not tags.length
      console.log 'No tag.'
      process.exit 1

    currentTime = moment()
    year = currentTime.format 'YYYY'
    month = currentTime.format 'MM'

    fs.mkdirSync postRoot if not fs.existsSync postRoot
    yearDir = path.join postRoot, year
    fs.mkdirSync yearDir if not fs.existsSync yearDir
    monthDir = path.join yearDir, month
    fs.mkdirSync monthDir if not fs.existsSync monthDir
    postDir = path.join monthDir, postDirName
    fs.mkdirSync postDir if not fs.existsSync postDir

    postContent = """---
title: #{ title }
layout: post
timestamp: #{ currentTime.format 'X' }
tags:
#{ tags.map((str) -> ' - ' + str).join '\n'  }
---
"""

    fs.writeFile path.join(postDir, 'index.html.md'), postContent, (err) ->
      if err
        console.log "Can't create a page."
        process.exit 1
      console.log 'Good.'

    rl.close()
