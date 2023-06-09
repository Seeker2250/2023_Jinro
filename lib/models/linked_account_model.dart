import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LinkedAccountModel extends GetxController {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  RxString linkedEmail = ''.obs;


  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  void setLinkedEmail(String email) {
    linkedEmail.value = email;
  }
}
