do ($ = jQuery) ->
  window.onfontactive = []
  WebFont.load
    google:
      families: ['Lato:100', 'Lato:300']
    active: ->
      window.onfontactive.forEach (handler) -> handler()

  window.onfontactive.push ->
    $('.shown-after-font-loaded').each ->
      opacity = 0
      increaseOpacity = ->
        if opacity >= 1
          @css 'opacity', 1
          return
        @css 'opacity', opacity
        opacity += 0.05
        setTimeout increaseOpacity.bind(@), 50
      increaseOpacity.call $(@)
