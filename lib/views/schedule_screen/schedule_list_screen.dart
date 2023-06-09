import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: Styles.mainMargin,
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                _buildTopTitleLayout(),
                _buildExampleListLayout(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTitleLayout() {
    return Column(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "작성한 시간표",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Styles.primaryColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Icon(
                  Icons.close,
                  color: Styles.primaryColor,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExampleListLayout() {
    return Container(
        height: 150,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: Styles.contentsDeco,
        child: Center(
            child: Text(
              "ListView_이곳에 저장된 시간표가 출력\n시간표 설정 페이지로 이동+삭제 버튼",
              style: Styles.contentsTitleTextStyle,
            )));
  }

}
