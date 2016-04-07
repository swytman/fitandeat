$ ->
  $('select').material_select();
  $('ul.tabs').tabs();

  $('.uisortable').sortable
    axis: 'y'
    handle: ".orderable-index"
    update: (event, ui) ->
      data = $(this).sortable('serialize')
      # POST to server using $.post or $.ajax
      self=$(this)
      $.ajax $(this).data('url'),
        data: data
        type: 'POST'

        success: (data, textStatus, jqXHR) ->
          for value, index in self.find('li.sortable-li')
            console.log(value)
            $(value).find('.orderable-index').html(index+1)