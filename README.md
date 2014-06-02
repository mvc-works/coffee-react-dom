
Coffee React DOM
------

CoffeeScript for React, instead of JSX.

### Usage

```
npm i --save-dev coffee-react-dom
```
```coffee
dom = require 'coffee-react-dom'

# need this unless `window.React.DOM` exists
# dom._init React.DOM

Comment = React.createClass
  displayName: 'Comment'
  render: ->
    props = @props
    dom -> @div class: 'comment',
      @h2 class: 'comment-author', props.author
      props.children
```

### Notice

* unless `window.React` exists, `dom._init(React.DOM)` is required
* `this` will be binded in `dom`, so specify variables for `props state...`
* use `displayName` otherwise you will get `<Unknown>` in devtools
* `@div` requires an object of properties to be first parameter

This is CommonJS module, just fork it for other needs.

### Implemenation

Merely calling `React.DOM.div` with `@div`, read `dom.coffee`:

```coffee
scope = {}

module.exports = (generator) ->
  generator.call scope

module.exports._init = (proto) ->
  bind proto

bind = (DOM) ->
  for tag, func of DOM
    scope[tag] = func

if window?.React?
  bind window.React.DOM
```

### Example

Read `coffee/main.coffee`:

```coffee
dom = require 'coffee-react-dom'

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
```

### Changelog

* `0.0.3`

  * removed alias `@` of `{}`
  * refactor to simplify code

### License

MIT