class @ExerciseList extends React.Component
  render: ->
    comments = @props.data.map (comment) ->
      return `<Exercise comment = {comment} />`
    console.log(comments)
    return `<div>{comments}</div>`

