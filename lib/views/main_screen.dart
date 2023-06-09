import 'package:flutter/material.dart';
import 'package:flutter_2023_project/utils/styles.dart';
import 'package:flutter_2023_project/views/mypage_screen/My_Information/mypage_screen.dart';
import 'schedule_screen/schedule_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: Styles.mainMargin,
        child: Center(
          child: ListView(
            children: <Widget>[
              _buildTopTitleLayout(),
              _buildScheduleLayout(),
              _buildQRCodeLayout(),
              _buildHorizontalListLayout(),
              _buildBusLocationLayout()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopTitleLayout() {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 수정된 부분
        children: [
          Text(
            "ForSMU",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Styles.primaryColor,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MyPageScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      )),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Icon(
              Icons.account_circle,
              color: Styles.primaryColor,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleLayout() {
    return Container(
      height: 140,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: Styles.contentsDeco,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "이번 학기 시간표가\n작성되지 않았어요",
            style: Styles.contentsTitleTextStyle.copyWith(fontWeight: FontWeight.w500)
          ),
          const SizedBox(height: 10),
          _navigateToScheduleScreenButton()
        ],
      ),
    );
  }

  Widget _buildQRCodeLayout() {
    return Container(
        height: 260,
        margin: Styles.mainContainerBottomMargin,
        decoration: Styles.contentsDeco.copyWith(color: Colors.grey),
        child: Center(
            child: Text(
          "QR code\n-준비중",
          style: Styles.contentsTitleTextStyle
        )));
  }

  Widget _buildHorizontalListLayout() {
    return Container(
        height: 140,
        margin: Styles.mainContainerBottomMargin,
        decoration: Styles.contentsDeco.copyWith(color: Colors.grey),
        child: Center(
            child: Text(
          "시간표 설정, 학사행정\n전자출결이동, 식단등\nListView 가로로 구성",
          style: Styles.contentsTitleTextStyle
        )));
  }

  Widget _buildBusLocationLayout() {
    return Container(
        height: 375,
        margin: Styles.mainContainerBottomMargin,
        decoration: Styles.contentsDeco.copyWith(color: Colors.grey),
        child: Center(
            child: Text(
          "버스 위치 정보 \nAPI활용\n-준비중",
          style: Styles.contentsTitleTextStyle
        )));
  }

  Widget _navigateToScheduleScreenButton(){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScheduleScreen(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "시간표 작성",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Styles.actionColor
            ),
          ),
          Icon(
            Icons.navigate_next,
            color: Styles.actionColor,
            size: 30
          ),
        ],
      ),
    );
  }
}
