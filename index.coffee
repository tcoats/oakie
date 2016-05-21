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
      return if !index[n]?
      parent = index
      index = index[n]
      if trunk?
        return if !index[trunk]?
        index = index[trunk]
    delete parent[leaf[leaf.length - 1]]

  select: (tree, leaf, trunk) ->
    result = tree
    index = tree
    for n in leaf
      return null if !index[n]?
      index = index[n]
      result = index
      if trunk?
        return null if !index[trunk]?
        index = index[trunk]
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
    result = []
    path.map (n) ->
      return result if !index[n]
      index = index[n]
      result.push fn index, n
      return result if !index[trunk]
      index = index[trunk]
