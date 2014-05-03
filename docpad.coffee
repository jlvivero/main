# DocPad Configuration File
# http://docpad.org/docs/config

moment = require 'moment'

# Define the DocPad Configuration
docpadConfig =
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

# Export the DocPad Configuration
module.exports = docpadConfig
