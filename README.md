
Coffee React DOM
------

CoffeeScript for React, instead of JSX.

### Some thoughts

Before looking into this module, there's another solution.
That is, running `$ = React.DOM` and use `$.div` to create elements.
In such way you are away from the problem caused by rewriting `@`.
Here's a demo:

```coffee
$ = React.DOM

Comment = React.createClass
  displayName: 'Comment'
  render: ->
    $.div class: 'comment',
      $.h2 class: 'comment-author', @props.author
      @props.children
```
Considering this, I think it would be better if I deprecate this package.

However, if you want it look better like `@div`, then read docs below.

### Usage

```bash
# with Browserify
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

Or you may choose `window.dom` function to use:
```bash
# or plain JavaScript, path is `lib/dom.js`
bower i --save coffee-react-dom
```

### Notice

* unless `window.React` exists, `dom._init(React.DOM)` is required
* `this` will be binded in `dom`, so specify variables for `props state...`
* use `displayName` otherwise you will get `<Unknown>` in devtools
* `@div` requires an object of properties to be first parameter

This is CommonJS module, just fork it for other needs.

### Implementaion

Merely calling `React.DOM.div` with `@div`, read `dom.coffee`:

```coffee
scope = {}

module.exports = (template) ->
  template.call scope
module.exports._init = (ReactDOM) ->
  bind ReactDOM

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

* `0.0.4`

  * add Bower package

* `0.0.3`

  * removed alias `@` of `{}`
  * refactor to simplify code

### License

MIT