window.onfontactive = []
WebFont.load
  google:
    families: ['Lato:100', 'Lato:300']
  active: ->
    window.onfontactive.forEach (handler) -> handler()
