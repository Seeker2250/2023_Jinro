import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';

class EditorController extends GetxController {
  // 현재 유저 아이디 (Test)
  final String _userID = "schedule_test";
  final _scheduleID = ''.obs;
  final _scheduleName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchScheduleID();
    fetchScheduleName();
  }

  // 저장할 수업추가 관련 변수정보 리스트
  final _selectedDaysMap = <int, String>{}.obs;
  final _selectedStartTimeMap = <int, DateTime>{}.obs;
  final _selectedEndTimeMap = <int, DateTime>{}.obs;
  final _lectureRoomMap = <int, String>{}.obs;
  final RxString _lectureName = ''.obs;
  final RxString _professorName = ''.obs;

  RxString get lectureName => _lectureName;

  RxString get professorName => _professorName;

  RxString get scheduleName => _scheduleName;
  // Future<String> getScheduleName() async {
  //   final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  //
  //   DatabaseReference userScheduleRef = databaseReference.child("users")
  //       .child(_userID).child("schedules").child(_scheduleID.toString()).child("ScheduleName");
  //
  //   DataSnapshot snapshot = await userScheduleRef.once().then((event) => event.snapshot);
  //
  //   if (snapshot.value != null) {
  //     print('value >> ${snapshot.value.toString()}');
  //     return snapshot.value.toString();
  //   } else {
  //     return '내 시간표';
  //   }
  // }

  int getSelectedDayMapLength() {
    return _selectedDaysMap.length;
  }

  int getSelectedDaysMapKeyElement(int index) {
    return _selectedDaysMap.keys.elementAt(index);
  }

  List<int> getSelectedDaysMapKeys() {
    return _selectedDaysMap.keys.toList();
  }

  String getSelectedDayMapValue(int containerId) {
    return _selectedDaysMap[containerId] ?? '';
  }

  DateTime getSelectedStartTimeValue(int containerId) {
    return _selectedStartTimeMap[containerId] ?? DateTime.now();
  }

  DateTime getSelectedEndTimeValue(int containerId) {
    return _selectedEndTimeMap[containerId] ?? DateTime.now();
  }

  void setSelectedDay(int containerId, String selectedDay) {
    _selectedDaysMap[containerId] = selectedDay;
  }

  void setSelectedStartTime(int containerId, DateTime time) {
    _selectedStartTimeMap[containerId] = time;
  }

  void setSelectedEndTime(int containerId, DateTime time) {
    _selectedEndTimeMap[containerId] = time;
  }

  void setLectureRoom(int containerId, String value) {
    _lectureRoomMap[containerId] = value;
  }

  void setLectureName(String value) {
    _lectureName.value = value;
  }

  void setProfessorName(String value) {
    _professorName.value = value;
  }

  void setScheduleName(String newScheduleName) {
    _scheduleName.value = newScheduleName;
  }

  void removeContainer(int containerId) {
    _selectedDaysMap.remove(containerId);
    _selectedStartTimeMap.remove(containerId);
    _selectedEndTimeMap.remove(containerId);
    _lectureRoomMap.remove(containerId);
  }

  void clearData() {
    _selectedDaysMap.clear();
    _selectedStartTimeMap.clear();
    _selectedEndTimeMap.clear();
    _lectureRoomMap.clear();
    _lectureName.value = '';
    _professorName.value = '';
  }

  // 시간표 제목 value 가져옴
  void fetchScheduleName() {
    final databaseReference = FirebaseDatabase.instance.ref();

    DatabaseReference userScheduleRef = databaseReference.child("users")
        .child(_userID).child("schedules").child(_scheduleID.toString()).child("ScheduleName");

    userScheduleRef.once().then((event) {
      DataSnapshot data = event.snapshot;
      if (data.value != null) {
        _scheduleName.value = data.value.toString();
      }else{
        _scheduleName.value = '내 시간표';
      }
    });
  }

  // 시간표에 해당하는 키 값을 받아옴
  void fetchScheduleID() {
    final databaseReference = FirebaseDatabase.instance.ref();

    DatabaseReference userSchedulesRef = databaseReference.child("users").child(_userID).child("schedules");

    userSchedulesRef.once().then((event) {
      DataSnapshot data = event.snapshot;
      Map<dynamic, dynamic>? schedules = data.value as Map<dynamic, dynamic>?;

      if (schedules != null && schedules.isNotEmpty) {
        String scheduleID = schedules.keys.first.toString();
        _scheduleID.value = scheduleID;
      } else {
        DatabaseReference newScheduleRef = userSchedulesRef.push();
        String scheduleID = newScheduleRef.key!;
        _scheduleID.value = scheduleID;
      }
    });
  }

  void saveScheduleNameToFirebase() async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

    _scheduleName.listen((value) {
      databaseRef.child('users').child(_userID)
          .child('schedules').child(_scheduleID.toString())
          .child('ScheduleName').set(value);
    });
  }

  // 저장 버튼을 누를 시 변수에 있는 데이터를 DB에 저장
  void addSchedule() {
    //User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users').child(_userID);
    DatabaseReference scheduleRef =
        userRef.child('schedules').child(_scheduleID.toString());

    Uuid uuid = const Uuid();
    final uuidMap = <int, String>{};

    // Data Insert
    scheduleRef.child("LectureName").set(_lectureName.value);
    scheduleRef.child("ProfessorName").set(_professorName.value);
    scheduleRef.child("ScheduleName").set(_scheduleName.value);

    _selectedDaysMap.forEach((key, value) async {
      uuidMap[key] ??= uuid.v4();
      await scheduleRef.child("Days/${uuidMap[key]}").set(value);
    });

    _selectedStartTimeMap.forEach((key, value) async {
      await scheduleRef.child("StartTime/${uuidMap[key]}").set(value.toIso8601String());
    });

    _selectedEndTimeMap.forEach((key, value) async {
      await scheduleRef.child("EndTime/${uuidMap[key]}").set(value.toIso8601String());
    });

    _lectureRoomMap.forEach((key, value) async {
      await scheduleRef.child("Rooms/${uuidMap[key]}").set(value);
    });
  }
}
