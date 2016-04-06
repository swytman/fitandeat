class ExercisesList
  constructor: (container) ->
    @e = $(container)
    @all_exercises = window.all_exercises
    @day_exercises = window.day_exercises
    @parent_id = window.parent_id
    @new_url = '/day_exercises'
    @blank_exercise = {id: '', exercise_id: null, count: '', description: ''}
    buttonHtml = this.newButtonHtml()
    btn = $('<div/>').html(buttonHtml).contents()
    @e.before(btn)
    for k,exercise of @day_exercises
      console.log(exercise)
      this.addItem(exercise)
    $('.exercises-add').click this.onAddClick

  newButtonHtml: () ->
    "<div class=\"row bottom20\"><div class=\"col s3 right\"><a class=\"btn right exercises-add waves-effect top10 waves-light\" href=\"#\">Добавить</a></div></div>"


  onAddClick: (event) =>
    this.addItem()

  onChangeItemSelect: (event) =>
    item = $(event.target).parents('.exercises-item')
    console.log('change')
    this.updateRequest(item)

  bindItem: (item) ->
    item.find('select').material_select()
    item.find('select, input').change this.onChangeItemSelect



  addItem: (exercise = @blank_exercise) ->
    itemHtml = this.itemHtml(exercise)
    item = $('<div/>').html(itemHtml).contents()
    console.log(itemHtml)
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
          $(item).attr('id', "item-#{data.id}")
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

  serializeItem: (item) ->
    item = $(item)
    console.log(item)
    exercise_id = item.find('select.exercise-id').val()
    count = item.find('.count').val()
    id = item.attr('id').split('_')[1]
    {id: id, exercise_id: exercise_id, count: count}


  itemHtml: (exercise) ->
    "<li class=\"row exercises-item\" id=\"items_#{exercise.id}\">
        #{this.exerciseSelectHtml(exercise.exercise_id)}
        #{this.exerciseCountHtml(exercise.count)}
    </li>"

  exerciseSelectHtml: (exercise_id) ->
    "<div class=\"col s4\">
      <select class=\"exercise-id\" placeholder=\"Выберите упражнение\">
        #{this.exerciseOptionsHtml(exercise_id)}
      </select>
     </div>"

  exerciseCountHtml: (count) ->
    console.log(count)
    count = '' if count=='null'
    "<div class=\"col s2\">
          <input type=\"text\" class=\"count\" value=\"#{count}\" placeholder=\"Повторений\"></input>
     </div>"


  exerciseOptionsHtml: (selected_id) ->
    console.log(selected_id)
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