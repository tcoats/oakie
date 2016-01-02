module.exports =
  add: (tree, leaf) ->
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      index = index[n]

  remove: (tree, leaf) ->
    parent = tree
    index = tree
    for n in leaf
      index[n] = {} if !index[n]?
      parent = index
      index = index[n]
    delete parent[leaf[leaf.length - 1]]
