$ ->
  alignContainer = ->
    container = $('#Container')
    containerHeight = container.outerHeight()
    windowHeight = $(window).height()
    if windowHeight > containerHeight
      container.css('margin-top', (windowHeight - containerHeight) / 2)
  alignContainer()
  $(window).resize alignContainer
