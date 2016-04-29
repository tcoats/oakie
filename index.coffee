

module.exports =
  add: (tree, leaf, payload) ->
    payload = {} if !payload?
    parent = tree
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      parent = index
      index = index[n]
    parent[leaf[leaf.length - 1]] = payload

  remove: (tree, leaf) ->
    parent = tree
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      parent = index
      index = index[n]
    delete parent[leaf[leaf.length - 1]]

  visit: (tree, trunk, fn) ->
    for key, value of tree
      fn key, value
      module.exports.visit value[trunk], trunk, fn if value[trunk]?

  flatten: (tree, trunk) ->
    result = {}
    module.exports.visit tree, trunk, (key, value) -> result[key] = value
    result
