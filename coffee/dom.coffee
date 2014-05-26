
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
  {}

if window?.React?
  bind window.React.DOM