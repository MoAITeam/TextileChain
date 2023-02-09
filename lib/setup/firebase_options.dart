// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBlb5q9vH3KLZmILDvel0EGPIe_HZGYPfY',
    appId: '1:788446035668:web:4927c9d323f8f7d58cc541',
    messagingSenderId: '788446035668',
    projectId: 'textile-tracking',
    authDomain: 'textile-tracking.firebaseapp.com',
    storageBucket: 'textile-tracking.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNXx6__h2eXhzkGKNA6e7b3JcNkHaRSQk',
    appId: '1:788446035668:android:69e9fc8730d955e58cc541',
    messagingSenderId: '788446035668',
    projectId: 'textile-tracking',
    storageBucket: 'textile-tracking.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbi5jFW2E0xzUN01mW8KIUc2CHlswLnBE',
    appId: '1:788446035668:ios:74e44f58de0a23368cc541',
    messagingSenderId: '788446035668',
    projectId: 'textile-tracking',
    storageBucket: 'textile-tracking.appspot.com',
    iosClientId: '788446035668-1gtfsj3pt80tef3qb4822n9t3cfkurd6.apps.googleusercontent.com',
    iosBundleId: 'io.flutterflow.codewords',
  );
}