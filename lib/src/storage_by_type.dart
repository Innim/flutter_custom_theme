/// Function to get element with type [E] from [storage].
typedef GetFromSubStorage<E> = E Function(StorageByType storage);

/// Storage for instances by type.
abstract class StorageByType {
  /// List of types in storage.
  Iterable<Type> get types;

  /// Obtains the instance of given type [E].
  ///
  /// If there is no instance for type, then `null` will be returned.
  E get<E>([GetFromSubStorage<E> func]);
}

/// Storage for instances by type.
class StorageByTypeImpl with StorageByTypeMixin {}

/// Mixin with functionality of storage for instances by type.
abstract class StorageByTypeMixin implements StorageByType {
  /// Map of instances.
  final Map<Type, dynamic> _map = {};
  final List<StorageByType> _subStorage = [];

  /// List of types in storage.
  Iterable<Type> get types => _map.keys;

  /// Set list of instances.
  ///
  /// List should not contain multiple instances with same type.
  /// Also list should not contain null.
  ///
  /// If [recursive] is `true` than
  void setData(Iterable data, {bool recursive = false}) {
    assert(data != null);
    data.forEach(recursive ? _addRecursive : _addInstance);
  }

  /// Obtains the instance of given type [E].
  ///
  /// If there is no instance for type, then `null` will be returned
  E get<E>([GetFromSubStorage<E> func]) {
    var res = _map[E];
    if (res == null && _subStorage.isNotEmpty) {
      for (final storage in _subStorage) {
        res = func != null ? func.call(storage) : storage.get<E>();
        if (res != null) return res;
      }
    }

    return res as E;
  }

  void _addInstance(item) {
    assert(item != null);

    final type = item.runtimeType;
    assert(_map.containsKey(type) == false);

    _map[type] = item;
  }

  void _addRecursive(item) {
    _addInstance(item);
    if (item is StorageByType) {
      _subStorage.add(item);
    }
  }
}
