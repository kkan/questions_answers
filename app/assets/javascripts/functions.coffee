window.toggleText = (el) ->
  oldText = el.text()
  el.text(el.data('toggleText'))
  el.data('toggleText', oldText)
