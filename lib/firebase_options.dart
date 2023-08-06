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
    apiKey: 'AIzaSyC8KhrqeoEs3UGj23QMprRZ2-ZALn1Z4so',
    appId: '1:947597075564:web:fb184686784654f982e449',
    messagingSenderId: '947597075564',
    projectId: 'cinereview-2d541',
    authDomain: 'cinereview-2d541.firebaseapp.com',
    storageBucket: 'cinereview-2d541.appspot.com',
    measurementId: 'G-6D2M0B9SGS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFiCgZ0KF2wkH0o-Ki37xo8tiVxbFl5FM',
    appId: '1:947597075564:android:080565c8becce78482e449',
    messagingSenderId: '947597075564',
    projectId: 'cinereview-2d541',
    storageBucket: 'cinereview-2d541.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAJ22LdqIrNNhSzVXay-8aCbq6Ho6kcW4',
    appId: '1:947597075564:ios:d53402366df752c982e449',
    messagingSenderId: '947597075564',
    projectId: 'cinereview-2d541',
    storageBucket: 'cinereview-2d541.appspot.com',
    iosClientId: '947597075564-fk9g5nj9kh6o2ovq6bplhgs3e5pdjt03.apps.googleusercontent.com',
    iosBundleId: 'com.example.cinereview',
  );
}
