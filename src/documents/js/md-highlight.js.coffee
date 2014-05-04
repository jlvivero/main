do ($=jQuery, hl=hljs) ->
  $('pre code').each ->
    obj = $ @
    code = obj.text()
    lang = obj.attr 'class'
    if lang? and lang
      lang = lang.replace /^lang\-/, ''
      obj.html hl.highlight(lang, code).value
