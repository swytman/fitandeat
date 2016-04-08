class window.DayExercise
  constructor: (exercise) ->
    @hash = exercise

  shortView: ->
    "<div class=\"exercise-short-container\">
          #{this.shortTitle()}
          #{this.shortDesc()}
    </div>"

  shortDesc: ->
    if @hash.description
      "<div class=\"exercise-short-description\">#{@hash.description}</div>"
    else
      ''

  shortTitle: ->
    if @hash.title
      "<div class=\"exercise-short-title\">#{@hash.title}</div>"
    else
      ''

