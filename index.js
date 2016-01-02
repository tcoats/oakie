// Generated by CoffeeScript 1.9.2
module.exports = {
  add: function(tree, leaf) {
    var i, index, len, n, results;
    index = tree;
    results = [];
    for (i = 0, len = leaf.length; i < len; i++) {
      n = leaf[i];
      if (index[n] == null) {
        index[n] = {};
      }
      results.push(index = index[n]);
    }
    return results;
  },
  remove: function(tree, leaf) {
    var i, index, len, n, parent;
    parent = tree;
    index = tree;
    for (i = 0, len = leaf.length; i < len; i++) {
      n = leaf[i];
      if (index[n] == null) {
        index[n] = {};
      }
      parent = index;
      index = index[n];
    }
    return delete parent[leaf[leaf.length - 1]];
  }
};
