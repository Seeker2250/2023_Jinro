import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxString _instructorName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  _loadData() async {
    var result = await _firestore.collection('Lecture').doc('eHBkBxzuk7JbnfSmyEQd').get();
    var data = result.data();
    _instructorName.value = data?['instructor_name'];
  }

  String getInstructorName() {
    return _instructorName.value;
  }
}


