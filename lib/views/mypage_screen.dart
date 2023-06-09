import 'package:flutter/material.dart';
import 'package:flutter_2023_project/utils/styles.dart';
import 'main_screen.dart';
class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _studentNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _departmentController.dispose();
    _studentNumberController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: Styles.mainMargin,
        child: Center(
          child: ListView(
            children: <Widget>[_buildTopTitleLayout(context), _buildInfoForm()],
          ),
        ),
      ),
    );
  }

  Widget _buildTopTitleLayout(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPageScreen()),
              );
            },
            child: Text(
              "내 정보",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainScreen()),
              );
            },
            child: Icon(
              Icons.home,
              color: Styles.primaryColor,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('닉네임'),
                TextField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(hintText: '닉네임을 입력하세요'),
                  style: const TextStyle(color : Colors.cyanAccent,),
                ),
                const Text('학과'),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(hintText: '학과를 입력하세요'),
                ),
                const Text('학번'),
                TextField(
                  controller: _studentNumberController,
                  decoration: const InputDecoration(hintText: '학번을 입력하세요'),
                ),
                const Text('이름'),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: '이름을 입력하세요'),
                ),
                const Text('등록된 이메일 계정'),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: '이메일을 입력하세요'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
