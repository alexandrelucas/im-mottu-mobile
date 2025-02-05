import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment("FIREBASE_API_KEY_ANDROID"),
    appId: String.fromEnvironment("FIREBASE_APP_ID_ANDROID"),
    messagingSenderId: String.fromEnvironment("FIREBASE_MESSAGE_SENDER_ID"),
    projectId: String.fromEnvironment("FIREBASE_PROJECT_ID"),
    storageBucket: String.fromEnvironment("FIREBASE_STORAGE_BUCKET"),
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment("FIREBASE_API_KEY_IOS"),
    appId: String.fromEnvironment("FIREBASE_APP_ID_IOS"),
    messagingSenderId: String.fromEnvironment("FIREBASE_MESSAGE_SENDER_ID"),
    projectId: String.fromEnvironment("FIREBASE_PROJECT_ID"),
    storageBucket: String.fromEnvironment("FIREBASE_STORAGE_BUCKET"),
    iosBundleId: String.fromEnvironment("FIREBASE_IOS_BUNDLE_ID"),
  );
}
