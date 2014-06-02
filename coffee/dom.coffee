
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