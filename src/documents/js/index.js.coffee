do ($ = jQuery) ->
  profConst =
    minHeight: 40
    minOpacity: 0.6
    imageMaxHeight: 200

  isTouchDevice = do ->
    if 'ontouchstart' of window
      true
    else if window.DocumentTouch and document instanceof window.DocumentTouch
      true
    else
      false

  scrollObject = if isTouchDevice then '#scroll-wrapper'  else document

  windowHeight = null
  updateProfile = ->
    profileDiv = $ '#profile'
    scrollTop = $(scrollObject).scrollTop()

    profileHeight = windowHeight - scrollTop * 2
    profileHeight = Math.max profConst.minHeight, profileHeight
    profileDiv.height profileHeight

    opacity = (windowHeight - scrollTop / 2) / windowHeight
    opacity = Math.max opacity, profConst.minOpacity
    profileDiv.css 'opacity', opacity

    buttonOpacity = (windowHeight - scrollTop * 4) / windowHeight
    buttonOpacity = Math.max buttonOpacity, 0
    $('div.scroll-down').css 'opacity', buttonOpacity

    profileImage = $('a.profile-image', profileDiv)
    profileImageHeight = Math.min profileHeight, profConst.imageMaxHeight
    profileImage.css
      'width': profileImageHeight
      'height': profileImageHeight
      'margin-top': -1 * profileImageHeight / 2

    aboutMe = $('div.about-me', profileImage)
    aboutMe.css
      'top': (profileImageHeight - profConst.minHeight) / 2

  renewWindowHeight = ->
    windowHeight = $(window).height()
    $('#content').css 'margin-top', windowHeight

  touchScrollSupport = ->
    body = $('body').css
      'width': $(window).width()
      'height': $(window).height()
    scrollWrapper = $("<div id='scroll-wrapper'></div>")
    body.children().detach().appendTo(scrollWrapper)
    scrollWrapper.appendTo body
    scrollWrapper.perfectScrollbar
      suppressScrollX: true
    scrollWrapper.scroll ->
      updateProfile()

  touchScrollUpdate = ->
    body = $('body').css
      'width': $(window).width()
      'height': $(window).height()
    $('#scroll-wrapper').perfectScrollbar 'update'

  $ ->
    renewWindowHeight()
    updateProfile()
    window.onfontactive.push ->
      $('#profile .wrapper').addClass 'shown'
    if isTouchDevice
      touchScrollSupport()
      window.onfontactive.push touchScrollUpdate
  $(window).resize ->
    renewWindowHeight()
    updateProfile()
    if isTouchDevice
      touchScrollUpdate()
  $(document).scroll ->
    updateProfile()
