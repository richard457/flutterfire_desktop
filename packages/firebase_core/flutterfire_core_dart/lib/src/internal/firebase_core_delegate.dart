// ignore_for_file: public_member_api_docs

part of flutterfire_core_dart;

/// An internal delegate to perform all Firebase core functionalities.

class FirebaseCoreDelegate {
  FirebaseCoreDelegate._();

  static final _instance = FirebaseCoreDelegate._();

  final Map<String, FirebaseApp> _apps = <String, FirebaseApp>{};

  List<FirebaseApp> get apps {
    return _apps.values.toList(growable: false);
  }

  Future<FirebaseApp> initializeApp({
    String? name,
    required FirebaseOptions options,
  }) async {
    /// Ensures the name isn't null, in case no name
    /// passed, [defaultFirebaseAppName] will be used
    final _name = name ?? defaultFirebaseAppName;

    if (_apps.containsKey(_name)) {
      throw duplicateApp(_name);
    }

    final _delegate = _FirebaseAppDelegete(this, _name, options);

    _apps[_name] = FirebaseApp._(_delegate);
    return _apps[_name]!;
  }

  FirebaseApp app([String name = defaultFirebaseAppName]) {
    if (_apps.containsKey(name)) {
      return _apps[name]!;
    }

    throw noAppExists(name);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FirebaseCoreDelegate) {
      return false;
    }
    return other.hashCode == hashCode;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => toString().hashCode;

  @override
  String toString() => '$FirebaseCoreDelegate';
}
