class ExercisesList
  constructor: (container) ->
    @e = $(container)
    @all_exercises = window.all_exercises
    @day_exercises = window.day_exercises
    html = this.newButtonHtml()
    console.log(html)
#    for exercise of @collections
#      html+=this.createItem(exercise)
    @e.html(html)
    $('.exercises-add').click this.onAddClick

  newButtonHtml: () ->
    "<div class=\"row bottom20\"><div class=\"col s3 right\"><a class=\"btn right exercises-add waves-effect top10 waves-light\" href=\"#\">Добавить</a></div></div>"


  onAddClick: (event) =>
    this.createItem()

  createItem: (exercise_id = null, count = '', description = '') ->
    itemHtml = this.itemHtml(exercise_id, count, description)
    item = $('<div/>').html(itemHtml).contents()
    item.appendTo(@e)
    item.find('select').material_select()



  itemHtml: (exercise_id, count, description) ->
    "<div class=\"row exercises-item\">
        #{this.exerciseSelectHtml(exercise_id)}
        #{this.exerciseCountHtml(count)}
    </div>"

  exerciseSelectHtml: (exercise_id) ->
    "<div class=\"col s4\">
      <select name=\"items[][exercise]\" placeholder=\"Выберите упражнение\">
        #{this.exerciseOptionsHtml(exercise_id)}
      </select>
     </div>"

  exerciseCountHtml: (count) ->
    "<div class=\"col s2\">
          <input type=\"text\" name=\"items[][count]\" value=\"#{count}\" placeholder=\"Повторений\"></input>
     </div>"



  exerciseOptionsHtml: (selected_id) ->
    options = "<option value disabled selected>...</option>"
    for item in @all_exercises
      selected = "selected=\"selected\"" if item.value == selected_id
      options+="<option value=\"#{item.value}\" #{selected}>#{item.label}</option>"
    options

$.fn.exercises_list = ->
  this.each ->
    new ExercisesList(this)

$ ->
  $('.exercises-list').exercises_list()