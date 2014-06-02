
scope = {}

if module?.exports?
  module.exports = (template) ->
    template.call scope
  module.exports._init = (ReactDOM) ->
    bind ReactDOM

else
  window.dom = (template) ->
    template.call scope

bind = (DOM) ->
  for tag, func of DOM
    scope[tag] = func

if window?.React?
  bind window.React.DOM