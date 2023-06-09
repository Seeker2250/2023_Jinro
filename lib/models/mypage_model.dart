import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_2023_project/models/mypage_model.dart';

class MypageModel extends GetxController {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final RxString enteredNickname = ''.obs;
  final RxString enteredDepartment = ''.obs;
  final RxString enteredStudentNumber = ''.obs;
  final RxString enteredName = ''.obs;
  final RxString enteredEmail = ''.obs;

  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('User_Information');

  void setEnteredNickname(String value) {
    enteredNickname.value = value;
  }

  void setEnteredDepartment(String value) {
    enteredDepartment.value = value;
  }

  void setEnteredStudentNumber(String value) {
    enteredStudentNumber.value = value;
  }

  void setEnteredName(String value) {
    enteredName.value = value;
  }

  void setEnteredEmail(String value) {
    enteredEmail.value = value;
  }

  Future<void> saveUserInfo() async {
    try {
      final DocumentReference userDocRef = await _usersCollection.add({
        'nickname': enteredNickname.value,
        'department': enteredDepartment.value,
        'studentNumber': enteredStudentNumber.value,
        'name': enteredName.value,
        'email': enteredEmail.value,
      });
      print('User info saved with ID: ${userDocRef.id}');
    } catch (e) {
      print('Error saving user info: $e');
    }
  }

  Future<void> loadUserInfo(String documentId) async {
    try {
      final DocumentSnapshot docSnapshot =
      await _usersCollection.doc(documentId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        enteredNickname.value = data['nickname'];
        enteredDepartment.value = data['department'];
        enteredStudentNumber.value = data['studentNumber'];
        enteredName.value = data['name'];
        enteredEmail.value = data['email'];
      } else {
        print('User info document does not exist');
      }
    } catch (e) {
      print('Error loading user info: $e');
    }
  }

  void resetInfo() {
    nicknameController.clear();
    departmentController.clear();
    studentNumberController.clear();
    nameController.clear();
    emailController.clear();
    enteredNickname.value = '';
    enteredDepartment.value = '';
    enteredStudentNumber.value = '';
    enteredName.value = '';
    enteredEmail.value = '';
  }
}
