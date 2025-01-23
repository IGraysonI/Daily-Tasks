/// {@template register}
/// Register for objects [T]
/// {@endtemplate}
abstract class Register<T extends Object> {
  /// {@macro register}
  Register();

  /// Registry for storage
  final Map<Type, T> _obj = {};

  /// Method for registering an object
  void register(Type type, T entry) => _obj[type] = entry;

  /// Method for getting a record by type
  T? getObj(Type type) => _obj[type];

  /// Method for getting a record by type
  Iterable<T> registerList() => _obj.values;

  /// Method for clearing the registry
  void destruct() => _obj.clear();
}
