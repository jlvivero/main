do ($=jQuery, hl=hljs) ->
  $('pre code').each ->
    obj = $ @
    code = obj.text()
    lang = obj.attr 'class'
    if lang? and lang
      lang = lang.replace /^lang\-/, ''
      try
        obj.html hl.highlight(lang, code).value
      catch error
        console.error error
