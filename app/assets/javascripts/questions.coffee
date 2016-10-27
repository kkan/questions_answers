# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  toggleText = (el) ->
    oldText = el.text()
    el.text(el.data('toggleText'))
    el.data('toggleText', oldText)

  $('.question').on 'click', '.edit-link', (e) ->
    e.preventDefault()
    toggleText($(this))
    $('.question-edit').toggle()
