# DocPad Configuration File
# http://docpad.org/docs/config

moment = require 'moment'

# Define the DocPad Configuration
docpadConfig =
  plugins:
    tags:
      relativeDirPath: 'tag'
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

    arrangePostData: (postData) ->
      result = {}
      for post in postData
        datetime = moment.unix(post.timestamp)
        year = datetime.year()
        month = datetime.month()
        if not result[year]?
          result[year] = {}
        if not result[year][month]?
          result[year][month] = []
        result[year][month].push post
      result = for year, months of result
        {
          year: year
          months: for month, posts of months
            {
              month: month
              monthStr: moment().month(Number(month)).format('MMM')
              posts: posts
            }
        }
      # Sorting
      for yearObj in result
        for monthObj in yearObj.months
          monthObj.posts.sort (a, b) ->
            b.timestamp - a.timestamp
        yearObj.months.sort (a, b) ->
          b.month - a.month
      result.sort (a, b) ->
        b.year - a.year
      result

# Export the DocPad Configuration
module.exports = docpadConfig
