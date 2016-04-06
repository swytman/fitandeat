# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.uisortable').sortable
    axis: 'y'
    update: (event, ui) ->
      data = $(this).sortable('serialize')
      # POST to server using $.post or $.ajax
      self=$(this)
      $.ajax $(this).data('url'),
        data: data
        type: 'POST'

        success: (data, textStatus, jqXHR) ->
          for value, index in self.find('li')
            console.log(value)
            $(value).find('.day-title').html(index+1)



