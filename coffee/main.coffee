
dom = require './dom'

Comment = React.createClass
  render: ->
    props = @props
    dom -> @div class: 'comment',
      @h2 class: 'comment-author', props.author
      props.children

CommentList = React.createClass
  render: ->
    commentNodes = @props.data.map (comment) ->
      Comment author: comment.author,
        comment.text
    dom -> @div class: 'comment-list',
      commentNodes

ComponentForm = React.createClass
  render: ->
    dom -> @div class: 'comment-form',
      'this is a comment form'

data = [
  author: "Pete Hunt", text: "This is one comment"
,
  author: "Jordan Walke", text: "This is *another* comment"
]

CommentBox = React.createClass
  render: ->
    props = @props
    dom -> @div class: 'comment-box',
      @h1 @, 'comments'
      CommentList data: props.data
      ComponentForm @

React.renderComponent (CommentBox data: data),
  document.querySelector('#app')