
;(function(window) {
  var scope = {};
  window.dom = function(template) {
    return template.call(scope);
  };

  if (window.React) {
    var DOM = window.React.DOM;
    for (tag in DOM) {
      scope[tag] = DOM[tag];
    }
  } else {
    throw (new Error('no window.React.DOM found!'))
  }
})(window);