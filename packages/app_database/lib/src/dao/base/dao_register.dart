import 'package:app_database/src/base/register.dart';
import 'package:app_database/src/dao/base/base_dao.dart';
import 'package:app_database/src/dao/base/basic_dao.dart';
import 'package:l/l.dart';

/// {@template dao_register}
/// Singleton register for objects of type [BasicDao]
/// {@endtemplate}
class DaoRegister extends Register<BasicDao> {
  /// {@macro dao_register}
  factory DaoRegister() => _instance;

  DaoRegister._() : super();

  static final DaoRegister _instance = DaoRegister._();

  /// Singleton instance
  static DaoRegister get instance => _instance;

  @override
  void register(Type type, BasicDao entry) {
    l.v6('Register DAO: $type');
    super.register(type, entry);
  }

  /// Get dao by type
  BasicDao getDao(Type type) {
    final dao = getObj(type);
    if (dao == null) throw Exception('DAO for $type not registered');
    return dao;
  }

  /// Get dao where type is [T]
  T getDaoWhereType<T extends IBaseDao>() {
    try {
      final dao = registerList().whereType<T>().firstOrNull;
      if (dao == null) throw Exception('DAO for $T ${T.runtimeType} not registered');
      return dao;
    } on Exception {
      throw Exception(
        'In _dataDaoMap, the DAO object of type $T was not found, '
        'implement the corresponding DAO!',
      );
    }
  }
}
