import 'package:flutter/material.dart';
import 'package:flutter_2023_project/utils/styles.dart';
import 'package:flutter_2023_project/views/main_screen.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/mypage_model.dart';
import '../about_linked_account/linked_account.dart';
import '../about_withdraw_membership/withdraw_membership.dart';

class MyPageScreen extends StatelessWidget {
  final MypageModel _model = Get.put(MypageModel());
  final _firestore = FirebaseFirestore.instance;

  MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: Styles.mainMargin,
        child: Center(
          child: ListView(
            children: <Widget>[
              _buildTopTitleLayout(context),
              const SizedBox(height: 16.0),
              _buildInfoForm(),
            ],
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
              ).then((result) {
                if (result != null) {
                  _model.setEnteredNickname(result['nickname']);
                  _model.setEnteredDepartment(result['department']);
                  _model.setEnteredStudentNumber(result['studentNumber']);
                  _model.setEnteredName(result['name']);
                  _model.setEnteredEmail(result['email']);
                  _model.saveUserInfo(); // Save the user info to Firebase
                }
              });
            },
            child: const Text(
              "For SMU",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xff3cded7),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.home,
              color: Color(0xff3cded7),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '내 정보',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 8.0),
                _buildInfoField('닉네임', TextFormField(
                  controller: _model.nicknameController,
                  decoration: const InputDecoration(hintText: '닉네임을 입력하세요'),
                  onChanged: (value) {
                    _model.setEnteredNickname(value);
                    _model.saveUserInfo(); // Save the user info to Firebase
                  },
                )),
                _buildInfoField('학과', TextFormField(
                  controller: _model.departmentController,
                  decoration: const InputDecoration(hintText: '학과를 입력하세요'),
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    _model.setEnteredDepartment(value);
                    _model.saveUserInfo(); // Save the user info to Firebase
                  },
                )),
                _buildInfoField('학번', TextFormField(
                  controller: _model.studentNumberController,
                  decoration: const InputDecoration(hintText: '학번을 입력하세요'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _model.setEnteredStudentNumber(value);
                    _model.saveUserInfo(); // Save the user info to Firebase
                  },
                )),
                _buildInfoField('이름', TextFormField(
                  controller: _model.nameController,
                  decoration: const InputDecoration(hintText: '이름을 입력하세요'),
                  onChanged: (value) {
                    _model.setEnteredName(value);
                    _model.saveUserInfo(); // Save the user info to Firebase
                  },
                )),
                FutureBuilder<DocumentSnapshot>(
                  future: _model.enteredEmail.isNotEmpty
                      ? _firestore.collection('users').doc(_model.enteredEmail.value).get()
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('데이터를 가져오는 중에 오류가 발생했습니다.');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!.data() as Map<String, dynamic>?; // 타입 명시
                      final email = data?['email'] as String? ?? '';
                      return _buildInfoField('등록된 이메일 계정', Text(email));
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 0), // Add SizedBox widget with desired height
        LinkedAccount(email: _model.enteredEmail.value),
        const SizedBox(height: 20),
        const WithdrawMembership(),
      ],
    );
  }

  Widget _buildInfoField(String label, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        field,
        const SizedBox(height: 16.0),
      ],
    );
  }
}