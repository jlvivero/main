# DocPad Configuration File
# http://docpad.org/docs/config

moment = require 'moment'

# Define the DocPad Configuration
docpadConfig =
  plugins:
    tags:
      relativeDirPath: 'tag/'
      extension: '.html'
      injectDocumentHelper: (doc) ->
        doc.setMeta
          layout: 'tag'

  templateData:
    site:
      title: 'noraesae'
      url: 'http://noraesae.net'
      email: 'me@noraesae.net'
      description: "noraesae's blog"
      keyword: "JavaScript,HTML5,CSS,Node.js,CoffeeScript,Frontend,Backend"

    sortByTimestamp: (collection) ->
      collection.sortCollection (a, b) ->
        b.get('timestamp') - a.get('timestamp')

    removeIndexHtmlFromUrl: (url) ->
      url.replace '/index.html', ''

    convertTimestampToRfc822: (timestamp) ->
      datetime = moment.unix(Number(timestamp)).zone(moment().zone())
      datetime.format('ddd, DD MMM YYYY HH:mm:ss ZZ')

    getMainTags: (tags) ->
      tagArray = for tag, data of tags
        data
      tagArray.sort (a, b) ->
        return b.count - a.count
      tagArray[0..2]

    tagWeightToFontSize: (weight) ->
      ((weight * 30) | 0) + 20

    arrangePostData: (postData) ->
      postData.sort (a, b) ->
        b.timestamp - a.timestamp

# Export the DocPad Configuration
module.exports = docpadConfig
