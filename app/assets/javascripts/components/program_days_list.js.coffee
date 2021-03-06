class ProgramDaysList
  constructor: (container) ->
    @e = $(container)
    @days = window.program_days || []
    @parent_id = window.parent_id
    @new_url = '/program_days'
    @blank_day = {id: '', day_exercises: []}
    buttonHtml = this.newButtonHtml()
    btn = $('<div/>').html(buttonHtml).contents()
    @e.before(btn)
    for k,day of @days
      this.addItem(day)
    $('.days-add').click this.onAddClick

  newButtonHtml: () ->
    "<div class=\"row bottom20\"><div class=\"col s3 right\"><div class=\"btn right days-add waves-effect top10 waves-light\">Добавить</div></div></div>"

  deleteButtonHtml: () ->
    "<div class=\"col s1 right\">
            <div class=\"btn right days-delete waves-effect waves-light\">
              <i class=\"material-icons\">not_interested</i>
            </div>
        </div>"

  addEditLink: (item) ->
    html = this.editLinkHtml(item)
    link = $('<div/>').html(html).contents()
    link.appendTo($(item))

  addCloneLink: (item) ->
    html = this.cloneSpanHtml(item)
    link = $('<div/>').html(html).contents()
    link.appendTo($(item))

  editLinkHtml: (item) ->
    id = this.serializeItem(item).id
    "<a class=\"days-edit \" href=\"/program_days/#{id}/edit\">
       Редактировать
    </a>"

  cloneSpanHtml: (item) ->
    id = this.serializeItem(item).id
    "<div class=\"col s1 right\">
        <div class=\"btn right days-clone waves-effect waves-light\" data-id=\"#{id}\">
          <i class=\"material-icons\">library_books</i>
        </div>
    </div>"

  onAddClick: (event) =>
    this.addItem()

  onDeleteClick: (event) =>
    if confirm "Удалить элемент?"
      item = $(event.target).parents('.days-item')
      this.deleteRequest(item)

  onCloneClick: (event) =>
    item = $(event.target).parents('.days-item')
    this.cloneRequest(item)

#  onChangeItemSelect: (event) =>
#    item = $(event.target).parents('.days-item')
#    this.updateRequest(item)

  bindItem: (item) ->
    item.find('.days-delete').click this.onDeleteClick
    item.find('.days-clone').click this.onCloneClick



  addItem: (day = @blank_day) ->
    itemHtml = this.itemHtml(day)
    item = $('<div/>').html(itemHtml).contents()
    item.appendTo(@e)
    this.createRequest(item) unless day.id
    this.addEditLink(item) if day.id
    this.addCloneLink(item) if day.id
    this.bindItem(item)

  createRequest: (item) ->
    data = {parent_id: @parent_id}
    self = @
    $.ajax @new_url,
      data: data
      type: 'POST'
      success: (data, textStatus, jqXHR) ->
        if data.program_day.id
          $(item).attr('id', "items_#{data.program_day.id}")
          self.addEditLink(item)
        else
          $(item).remove()
      error: (data, textStatus, jqXHR) ->
        $(item).remove

  cloneRequest: (item) ->
    id = @serializeItem(item).id
    self = @
    $.ajax "/api/clone_program_day",
      data: {id: id}
      type: 'POST'
      success: (data, textStatus, jqXHR) ->
        day = data.program_day
        self.addItem(day)
      error: (data, textStatus, jqXHR) ->
        console.log(data)

  deleteRequest: (item) ->
    day = this.serializeItem(item)
    $.ajax @new_url+"/#{day.id}",
      data: {parent_id: @parent_id}
      type: 'DELETE'
      success: (data, textStatus, jqXHR) ->
        $(item).remove()
        $('li.days-item').each (index)->
          $(this).find('.days-order').html(index+1)
      error: (data, textStatus, jqXHR) ->
        console.log(data)

  serializeItem: (item) ->
    id = item.attr('id').split('_')[1]
    {id: id}

  itemHtml: (day) ->
    console.log(day)
    order = $('li.days-item').length+1
    order = day.order  if day.order
    "<li class=\"row sortable-li days-item\" id=\"items_#{day.id}\">
          <div class=\"days-order orderable-index\">#{order}</div>
          <div class=\"col s9\">
            <div class=\"days-description\">#{this.buildShortDesc(day.day_exercises)}</div>
          </div>
          #{this.deleteButtonHtml()}
    </li>"

  buildShortDesc: (list) ->
    return '(пусто)' if list.length == 0
    res = ''
    for item in list
      exercise = new DayExercise(item)
      res+=exercise.shortView()
    res


$.fn.days_list = ->
  this.each ->
    new ProgramDaysList(this)

$ ->
  $('.days-list').days_list()