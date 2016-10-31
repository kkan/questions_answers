ready = (e)->
  $('.question').on 'click', '.edit-link', (e) ->
    e.preventDefault()
    toggleText($(this))
    $('.question-edit').toggle()

$(document).on('turbolinks:load', ready)
