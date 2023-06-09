import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_2023_project/firebase_options.dart';
import 'package:flutter_2023_project/views/mypage_screen/about_linked_account/school_account_sync_choice_.dart';
import 'package:flutter_2023_project/views/mypage_screen/about_linked_account/linked_account.dart';
import 'package:flutter_2023_project/views/splash_screen.dart';

import 'models/school_account_sync_choice_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'none',
      theme: ThemeData(
        fontFamily: 'LINE',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/school_account_sync_choice', page: () => SchoolAccountSyncChoice()),
        GetPage(name: '/linked_account', page: () => const LinkedAccount(email: '',)),
      ],
      onGenerateRoute: (settings) {
        if (settings.name == '/linked_account') {
          final userEmail = Get.find<SchoolAccountSyncChoiceModel>().userEmail;
          return MaterialPageRoute(
            builder: (context) => LinkedAccount(email: userEmail),
          );
        }
        return null;
      },
    );
  }
}
