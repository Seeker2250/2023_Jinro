import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_2023_project/views/mypage_screen/about_linked_account/school_account_sync_choice_.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_2023_project/views/main_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const MainScreen()
      )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'assets/images/public/logo_test.svg';

    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;


    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.384375),
              SvgPicture.asset(
                imageLogoName,
                width: screenWidth * 0.616666,
                height: screenHeight * 0.0859375,
              ),
              const Expanded(child: SizedBox()),
              Align(
                child: Text("© Copyright 2022",
                    style: TextStyle(
                      fontSize: screenWidth * (14 / 360),
                      color: const Color.fromRGBO(255, 255, 255, 0.6),)
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0625,),
            ],
          ),
        ),
      ),
    );
  }
}
