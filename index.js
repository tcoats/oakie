// Generated by CoffeeScript 1.10.0
module.exports = {
  add: function(tree, leaf, payload, trunk) {
    var i, index, len, n, parent;
    if (payload == null) {
      payload = {};
    }
    parent = tree;
    index = tree;
    for (i = 0, len = leaf.length; i < len; i++) {
      n = leaf[i];
      if (index[n] == null) {
        index[n] = {};
      }
      parent = index;
      index = index[n];
      if (trunk != null) {
        if (index[trunk] == null) {
          index[trunk] = {};
        }
        index = index[trunk];
      }
    }
    return parent[leaf[leaf.length - 1]] = payload;
  },
  remove: function(tree, leaf, trunk) {
    var i, index, len, n, parent;
    parent = tree;
    index = tree;
    for (i = 0, len = leaf.length; i < len; i++) {
      n = leaf[i];
      if (index[n] == null) {
        return;
      }
      parent = index;
      index = index[n];
      if (trunk != null) {
        if (index[trunk] == null) {
          return;
        }
        index = index[trunk];
      }
    }
    return delete parent[leaf[leaf.length - 1]];
  },
  select: function(tree, leaf, trunk) {
    var i, index, len, n, result;
    result = tree;
    index = tree;
    for (i = 0, len = leaf.length; i < len; i++) {
      n = leaf[i];
      if (index[n] == null) {
        return null;
      }
      index = index[n];
      result = index;
      if (trunk != null) {
        if (index[trunk] == null) {
          return null;
        }
        index = index[trunk];
      }
    }
    return result;
  },
  visit: function(tree, trunk, fn) {
    var key, results, value;
    results = [];
    for (key in tree) {
      value = tree[key];
      fn(key, value);
      if (value[trunk] != null) {
        results.push(module.exports.visit(value[trunk], trunk, fn));
      } else {
        results.push(void 0);
      }
    }
    return results;
  },
  flatten: function(tree, trunk) {
    var result;
    result = {};
    module.exports.visit(tree, trunk, function(key, value) {
      return result[key] = value;
    });
    return result;
  },
  dive: function(tree, trunk, path, fn) {
    var i, index, len, n, result;
    index = tree;
    result = [];
    for (i = 0, len = path.length; i < len; i++) {
      n = path[i];
      if (!index[n]) {
        return result;
      }
      index = index[n];
      result.push(fn(index, n));
      if (!index[trunk]) {
        return result;
      }
      index = index[trunk];
    }
  }
};
