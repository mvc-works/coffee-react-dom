
Coffee React DOM
------

Write JSX in CoffeeScript in React apps.

This is not a mature solution, but you can try and have fun.

### Usage

```
npm i --save-dev coffee-react-dom # browserify
```
```coffee
dom = require 'coffee-react-dom'

Comment = React.createClass
  displayName: 'Comment'
  render: ->
    props = @props
    dom -> @div class: 'comment',
      @h2 class: 'comment-author', props.author
      props.children

CommentList = React.createClass
  displayName: 'CommentList'
  render: ->
    commentNodes = @props.data.map (comment) ->
      Comment author: comment.author,
        comment.text
    dom -> @div class: 'comment-list',
      commentNodes

ComponentForm = React.createClass
  displayName: 'ComponentForm'
  render: ->
    dom -> @div class: 'comment-form',
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
    dom -> @div class: 'comment-box',
      @h1 @, 'comments'
      CommentList data: props.data
      ComponentForm @

React.renderComponent (CommentBox data: data),
  document.querySelector('#app')
```

### Implemenation

It quite simple, only calling `React.DOM.div` with `@div`:

```coffee
scope = {}

module.exports = (generator) ->
  generator.call scope

module.exports._init = (proto) ->
  bind proto

bind = (DOM) ->
  Object.keys(DOM).map (tag) ->
    scope[tag] = (prop={}, child...) ->
      if prop is scope then prop = {}
      DOM[tag] prop, child...

if window?.React?
  bind window.React.DOM
```

`@` is special, it reprecents `{}` in the place of props.

If there's no `window.React`, then comes `dom._init(React.DOM)`.

So simple that follows problems.
In React's debugging tool, it just shows `<Unknown>`.

### License

MIT