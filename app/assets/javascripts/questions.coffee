toggleText = (el) ->
  oldText = el.text()
  el.text(el.data('toggleText'))
  el.data('toggleText', oldText)

ready = (e)->
  $('.question').on 'click', '.edit-link', (e) ->
    e.preventDefault()
    toggleText($(this))
    $('.question-edit').toggle()

$(document).on('turbolinks:load', ready)
