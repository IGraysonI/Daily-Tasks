import 'package:flutter/foundation.dart';

/// Enviroment enums
enum Enviroment {
  /// Delelopment environment
  dev._('DEV'),

  /// Staging environment
  staging._('STAGING'),

  /// Production environment
  prod._('PROD');

  /// The environment value.
  final String value;

  const Enviroment._(this.value);

  /// Returns the enviroment from the given [value].
  static Enviroment from(String? value) => switch (value) {
        'DEV' => Enviroment.dev,
        'STAGING' => Enviroment.staging,
        'PROD' => Enviroment.prod,
        _ => kReleaseMode ? Enviroment.prod : Enviroment.dev,
      };
}
