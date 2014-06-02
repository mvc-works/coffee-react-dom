
dom = require './dom'

# need this unless `window.React.DOM` exists
# dom._init React.DOM

Comment = React.createClass
  displayName: 'Comment'
  render: ->
    props = @props
    dom -> @div className: 'comment',
      @h2 className: 'comment-author', props.author
      props.children

CommentList = React.createClass
  displayName: 'CommentList'
  render: ->
    commentNodes = @props.data.map (comment, index) ->
      Comment author: comment.author, key: index,
        comment.text
    dom -> @div className: 'comment-list',
      commentNodes

ComponentForm = React.createClass
  displayName: 'ComponentForm'
  render: ->
    dom -> @div className: 'comment-form',
      'this is a comment form'

data = [
  author: "Pete Hunt", text: "This is one comment"
,
  author: "Jordan Walke", text: "This is *another* comment"
]

CommentBox = React.createClass
  displayName: 'CommentBox'
  render: ->
    props = @props
    dom -> @div className: 'comment-box',
      @h1 {}, 'comments'
      CommentList data: props.data
      ComponentForm {}

React.renderComponent (CommentBox data: data),
  document.querySelector('#app')