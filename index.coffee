module.exports =
  add: (tree, leaf, payload, trunk) ->
    payload = {} if !payload?
    parent = tree
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      parent = index
      index = index[n]
      if trunk?
        index[trunk] = {} if !index[trunk]?
        index = index[trunk]
    parent[leaf[leaf.length - 1]] = payload

  remove: (tree, leaf, trunk) ->
    parent = tree
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      parent = index
      index = index[n]
      index = index[trunk] if trunk?
    delete parent[leaf[leaf.length - 1]]

  select: (tree, leaf, trunk) ->
    result = tree
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      index = index[n]
      result = index
      index = index[trunk] if trunk?
    result

  visit: (tree, trunk, fn) ->
    for key, value of tree
      fn key, value
      module.exports.visit value[trunk], trunk, fn if value[trunk]?

  flatten: (tree, trunk) ->
    result = {}
    module.exports.visit tree, trunk, (key, value) -> result[key] = value
    result

  dive: (tree, trunk, path, fn) ->
    index = tree
    path.map (n) ->
      index = index[n]
      res = fn index, n
      index = index[trunk]
      res
