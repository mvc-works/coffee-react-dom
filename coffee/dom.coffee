
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