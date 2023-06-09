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
    apiKey: 'AIzaSyBL1Fzna8DYMoZhx-zW1kUFQ7cw6oS814s',
    appId: '1:601415769028:android:c638268b2f411e5e9de291',
    messagingSenderId: '601415769028',
    projectId: 'forsmu-6a11b',
    databaseURL: 'https://forsmu-6a11b-default-rtdb.firebaseio.com',
    storageBucket: 'forsmu-6a11b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeAX6ErTSoeXtXSbw5XsOVTHSGzFH3u3Y',
    appId: '1:601415769028:ios:1f25cdf78d3adfb79de291',
    messagingSenderId: '601415769028',
    projectId: 'forsmu-6a11b',
    databaseURL: 'https://forsmu-6a11b-default-rtdb.firebaseio.com',
    storageBucket: 'forsmu-6a11b.appspot.com',
    iosClientId: '601415769028-sn8j9qdmkrguarrckua1i1mtijt9rgpa.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutter2023Project',
  );
}
