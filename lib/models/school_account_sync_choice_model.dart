import 'package:get/get.dart';

class SchoolAccountSyncChoiceModel extends GetxController {
  String _userEmail = '';
  String userPassword = '';

  String get userEmail => _userEmail;

  void setUserEmail(String email) {
    _userEmail = email;
    update();
  }
}
