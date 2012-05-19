$ ->
  $('li.image').tooltip
    title: ->
      $(@).find('input:hidden[name=title]').val()
