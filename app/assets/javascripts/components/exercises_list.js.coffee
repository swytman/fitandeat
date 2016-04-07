class ExercisesList
  constructor: (container) ->
    @e = $(container)
    @all_exercises = window.all_exercises
    @day_exercises = window.day_exercises
    @parent_id = window.parent_id
    @new_url = '/day_exercises'
    @blank_exercise = {id: '', exercise_id: null, count: 0, description: ''}
    buttonHtml = this.newButtonHtml()
    btn = $('<div/>').html(buttonHtml).contents()
    @e.before(btn)
    for k,exercise of @day_exercises
      this.addItem(exercise)
    $('.exercises-add').click this.onAddClick

  newButtonHtml: () ->
    "<div class=\"row bottom20\"><div class=\"col s3 right\"><a class=\"btn right exercises-add waves-effect top10 waves-light\" href=\"#\">Добавить</a></div></div>"

  deleteButtonHtml: () ->
    "<div class=\"col s1 right\">
        <a class=\"btn right exercises-delete waves-effect waves-light\" href=\"#\">
          <i class=\"material-icons\">not_interested</i>
        </a>
    </div>"

  onAddClick: (event) =>
    this.addItem()

  onDeleteClick: (event) =>
    if confirm "Удалить элемент?"
      item = $(event.target).parents('.exercises-item')
      this.deleteRequest(item)

  onChangeItemSelect: (event) =>
    item = $(event.target).parents('.exercises-item')
    this.updateRequest(item)

  bindItem: (item) ->
    item.find('select').material_select()
    item.find('select, input, textarea').change this.onChangeItemSelect
    item.find('.exercises-delete').click this.onDeleteClick



  addItem: (exercise = @blank_exercise) ->
    itemHtml = this.itemHtml(exercise)
    item = $('<div/>').html(itemHtml).contents()
    item.appendTo(@e)
    this.createRequest(item) unless exercise.id
    this.bindItem(item)

  createRequest: (item) ->
    data = {parent_id: @parent_id}
    $.ajax @new_url,
      data: data
      type: 'POST'
      success: (data, textStatus, jqXHR) ->
        if data.id
          $(item).attr('id', "items_#{data.id}")
        else
          $(item).remove()
      error: (data, textStatus, jqXHR) ->
        $(item).remove

  updateRequest: (item) ->
    exercise = this.serializeItem(item)
    data = {}
    $.ajax @new_url+"/#{exercise.id}",
      data: exercise
      type: 'PATCH'
      success: (data, textStatus, jqXHR) ->
        console.log(data)
      error: (data, textStatus, jqXHR) ->
        console.log(data)

  deleteRequest: (item) ->
    exercise = this.serializeItem(item)
    $.ajax @new_url+"/#{exercise.id}",
      data: {parent_id: @parent_id}
      type: 'DELETE'
      success: (data, textStatus, jqXHR) ->
        $(item).remove()
        $('li.exercises-item').each (index)->
          $(this).find('.exercises-order').html(index+1)
      error: (data, textStatus, jqXHR) ->
        console.log(data)

  serializeItem: (item) ->
    item = $(item)
    exercise_id = item.find('select.exercises-id').val()
    count = item.find('.exercises-count').val()
    desc =  item.find('textarea.exercises-description').val()
    id = item.attr('id').split('_')[1]
    {id: id, exercise_id: exercise_id, count: count, description: desc}


  itemHtml: (exercise) ->
    order = $('li.exercises-item').length+1
    order = exercise.order  if exercise.order
    "<li class=\"row sortable-li exercises-item\" id=\"items_#{exercise.id}\">
          <div class=\"exercises-order orderable-index\">#{order}</div>
          #{this.exerciseSelectHtml(exercise.exercise_id)}
          #{this.exerciseCountHtml(exercise.count)}
          #{this.exerciseDescHtml(exercise.description)}
          #{this.deleteButtonHtml()}
    </li>"

  exerciseSelectHtml: (exercise_id) ->
    "<div class=\"col s4\">
      <select class=\"exercises-id\" placeholder=\"Выберите упражнение\">
        #{this.exerciseOptionsHtml(exercise_id)}
      </select>
     </div>"

  exerciseCountHtml: (count) ->
    count = '' if count=='null' || count==null
    "<div class=\"col s1\">
          <input type=\"text\" class=\"exercises-count\" value=\"#{count}\"></input>
     </div>"

  exerciseDescHtml: (desc) ->
    count = 0 if count=='null' || count==null
    "<div class=\"col s4\">
          <textarea class=\"exercises-description materialize-textarea\" placeholder=\"Описание\">#{desc}</textarea>
     </div>"


  exerciseOptionsHtml: (selected_id) ->
    options = "<option value disabled selected>...</option>"
    for item in @all_exercises
      selected = ''
      selected = "selected=\"selected\"" if item.value == selected_id
      options+="<option value=\"#{item.value}\" #{selected}>#{item.label}</option>"
    options

$.fn.exercises_list = ->
  this.each ->
    new ExercisesList(this)

$ ->
  $('.exercises-list').exercises_list()