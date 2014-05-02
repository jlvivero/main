do ($ = jQuery) ->
  profConst =
    minHeight: 40
    minOpacity: 0.6
    imageMaxHeight: 200

  windowHeight = null
  updateProfile = () ->
    profileDiv = $ '#profile'
    scrollTop = $(document).scrollTop()

    profileHeight = windowHeight - scrollTop * 2
    profileHeight = Math.max profConst.minHeight, profileHeight
    profileDiv.height profileHeight

    opacity = (windowHeight - scrollTop / 2) / windowHeight
    opacity = Math.max opacity, profConst.minOpacity
    profileDiv.css 'opacity', opacity

    profileImage = $('a.profile-image', profileDiv)
    profileImageHeight = Math.min profileHeight, profConst.imageMaxHeight
    profileImage.css
      'width': profileImageHeight
      'height': profileImageHeight
      'margin-top': -1 * profileImageHeight / 2
    $('div.about-me', profileImage).css
      'top': (profileImageHeight - profConst.minHeight) / 2

  renewWindowHeight = () ->
    windowHeight = $(window).height()
    $('#content').css 'margin-top', windowHeight

  $ ->
    renewWindowHeight()
    updateProfile()
  $(window).resize ->
    renewWindowHeight()
    updateProfile()
  $(document).scroll ->
    updateProfile()
