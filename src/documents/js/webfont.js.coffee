WebFont.load
  google:
    families: ['Lato:100', 'Lato:300']
  active: ->
    if window.onfontactive? and window.onfontactive
      window.onfontactive()
