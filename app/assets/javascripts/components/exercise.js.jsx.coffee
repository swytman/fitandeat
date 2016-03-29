class @Exercise extends React.Component

  render: ->
    `<div className='z-depth-2 exercise'>
      <div className ='exercise-title'>Title: {this.props.comment.title}</div>
      <div className = 'exercise-description'>Description: {this.props.comment.description}</div>
    </div>`
