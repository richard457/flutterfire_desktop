library firebase_core_desktop;

import 'package:flutterfire_core_dart/flutterfire_core_dart.dart' as core_dart;
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

part 'firebase_app_desktop.dart';

/// Desktop implementation of FirebaseCore for managing Firebase app
/// instances.
class FirebaseCore extends FirebasePlatform {
  /// Called by PluginRegistry to register this plugin as the implementation for Desktop
  static void registerWith() {
    FirebasePlatform.instance = FirebaseCore();
  }

  FirebaseApp _mapDartToPlatfromApp(core_dart.FirebaseApp app) {
    return FirebaseApp._(
      app.name,
      FirebaseOptions.fromMap(app.options.asMap),
    );
  }

  @override
  List<FirebaseApp> get apps {
    return core_dart.Firebase.apps
        .map(_mapDartToPlatfromApp)
        .toList(growable: false);
  }

  @override
  Future<FirebaseApp> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    assert(options != null);
    // Initialize the app in flutterfire_core_dart
    final _dartOptions = core_dart.FirebaseOptions.fromMap(options!.asMap);
    final _dartApp = await core_dart.Firebase.initializeApp(
      name: name,
      options: _dartOptions,
    );

    return _mapDartToPlatfromApp(_dartApp);
  }

  @override
  FirebaseApp app([String name = defaultFirebaseAppName]) {
    try {
      return _mapDartToPlatfromApp(core_dart.Firebase.app(name));
    } catch (_) {
      throw noAppExists(name);
    }
  }
}
