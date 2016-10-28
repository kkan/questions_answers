ready = (e)->
  $('.answers').on 'click', '.edit-link', (e) ->
    e.preventDefault()
    toggleText($(this))
    $(this).parents('.edit-wrapper').find('.answer-edit').toggle()

$(document).on('turbolinks:load', ready)
