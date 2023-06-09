import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../../view_models/schedule_view_widget.dart';
import '../../utils/styles.dart';
import '../../models/schedule_editor_controller.dart';

class ScheduleEditorScreen extends StatefulWidget {
  const ScheduleEditorScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleEditorScreen> createState() => _ScheduleEditorScreenState();
}

class _ScheduleEditorScreenState extends State<ScheduleEditorScreen> {

  @override
  void initState() {
    super.initState();
    editorController = Get.put(EditorController());
  }

  @override
  void dispose() {
    lectureNameController.dispose();
    professorNameController.dispose();
    containerList.clear();
    containerIdList.clear();
    super.dispose();
  }

  late EditorController editorController;
  final _days = ['월요일', '화요일', '수요일', '목요일', '금요일'];
  final lectureNameController = TextEditingController();
  final professorNameController = TextEditingController();

  // 동적 위젯을 담는 리스트
  RxList<Widget> containerList = RxList<Widget>();

  // 위젯 구분 인덱스 부여
  List<int> containerIdList = [];
  int _currentContainerId = 0;

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
                SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildScheduleView(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLectureNameFieldWidget(),
                _buildProfessorNameFieldWidget(),
                Obx(() => Column(
                      children: containerList,
                    )),
                _buildTimePlaceAddButtonWidget(),
                const SizedBox(height: 50)
              ],
            ),
            _buildSaveButtonWidget(context),
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
                "수업 추가하기",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Styles.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  editorController.clearData();
                  containerList.clear();
                  Navigator.pop(
                    context,
                  );
                },
                child: Icon(
                  Icons.close,
                  color: Styles.primaryColor,
                  size: 50,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // 수업명 입력 필드
  Widget _buildLectureNameFieldWidget() {
    return Container(
        height: 60,
        decoration: Styles.contentsDeco,
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Center(
            child: Padding(
                padding: Styles.defaultPadding,
                child: _buildTextFieldStyle('수업명', 'lectureName'))));
  }

  // 교수명 입력 필드
  Widget _buildProfessorNameFieldWidget() {
    return Container(
        height: 60,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: Styles.contentsDeco,
        child: Center(
          child: Padding(
            padding: Styles.defaultPadding,
            child: _buildTextFieldStyle('교수명', 'professorName'),
          ),
        ));
  }

  // 시간 및 장소를 추가
  Widget _buildTimePlaceAddButtonWidget() {
    return Container(
      margin: Styles.mainContainerBottomMargin,
      child: InkWell(
        onTap: () {
          setState(() {
            Widget containerWidget = _buildCreateFieldWidget();
            containerList
                .add(containerWidget); // 이 동작 내부  _currentContainerId++
            containerIdList.add(_currentContainerId - 1);
          });
        },
        splashColor: Colors.transparent, // 터치 효과 비활성화
        highlightColor: Colors.transparent, // 하이라이트 효과 비활성화
        child: Row(
          children: [
            Flexible(
              child: Text(
                '시간 및 장소 추가',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Styles.actionColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 시간 및 장소 추가를 누를 경우 생성될 필드
  Widget _buildCreateFieldWidget() {
    int containerId = _currentContainerId++;

    DateTime now = DateTime.now();
    editorController.setSelectedDay(containerId, _days[0]);
    editorController.setSelectedStartTime(
        containerId, DateTime(now.year, now.month, now.day, 9, 30));
    editorController.setSelectedEndTime(
        containerId, DateTime(now.year, now.month, now.day, 10, 20));

    return Container(
        height: 120,
        margin: Styles.mainContainerBottomMargin,
        decoration: Styles.contentsDeco,
        child: Padding(
            padding: Styles.defaultPadding,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            underline: null,
                            value: editorController
                                .getSelectedDayMapValue(containerId),
                            items: _days
                                .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          )),
                                    ))
                                .toList(),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black87,
                            ),
                            onChanged: (value) {
                              editorController.setSelectedDay(
                                  containerId, value!);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Obx(
                        () => TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildTimePickerDialogWidget(
                                    containerId, 0);
                              },
                            );
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  DateFormat('HH:mm').format(editorController
                                      .getSelectedStartTimeValue(containerId)),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87
                                  )),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black87
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Obx(
                        () => TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildTimePickerDialogWidget(
                                    containerId, 1);
                              },
                            );
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  DateFormat('HH:mm').format(editorController
                                      .getSelectedEndTimeValue(containerId)),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  )),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.black87,
                        onPressed: () {
                          editorController.removeContainer(containerId);
                          setState(() {
                            containerList.removeWhere((widget) =>
                                containerIdList[
                                    containerList.indexOf(widget)] ==
                                containerId);
                            containerIdList.remove(containerId);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                TextField(
                  style: Styles.inputFieldTextStyle,
                  decoration: const InputDecoration(
                      hintText: '장소',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      )),
                  cursorColor: Styles.primaryColor,
                  onChanged: (value) {
                    editorController.setLectureRoom(containerId, value);
                  },
                ),
              ],
            )));
  }

  // 시간 선택 다이얼로그 위젯
  Widget _buildTimePickerDialogWidget(containerId, timeCase) {
    DateTime initialTime;

    if (timeCase == 0) {
      initialTime = editorController.getSelectedStartTimeValue(containerId);
    } else if (timeCase == 1) {
      initialTime = editorController.getSelectedEndTimeValue(containerId);
    } else {
      initialTime = DateTime.now();
    }

    return AlertDialog(
      backgroundColor: Styles.blockBackgroundColor,
      content: TimePickerSpinner(
        is24HourMode: true,
        normalTextStyle: const TextStyle(fontSize: 24, color: Colors.white60),
        highlightedTextStyle:
            const TextStyle(fontSize: 24, color: Colors.white),
        time: initialTime,
        onTimeChange: (time) {
          if (timeCase == 0) {
            editorController.setSelectedStartTime(containerId, time);
          } else if (timeCase == 1) {
            editorController.setSelectedEndTime(containerId, time);
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }

  // 텍스트 필드 스타일 정의
  Widget _buildTextFieldStyle(hint, fieldCase) {
    return TextField(
        controller: fieldCase == 'lectureName'
            ? lectureNameController
            : professorNameController,
        // 입력되는 글자 스타일 정의
        style: Styles.inputFieldTextStyle,
        decoration: Styles.hintDeco.copyWith(hintText: hint),
        cursorColor: Styles.primaryColor,
        onChanged: (value) {
          if (fieldCase == 'lectureName') {
            editorController.setLectureName(value);
          } else if (fieldCase == 'professorName') {
            editorController.setProfessorName(value);
          }
        });
  }

  // 저장 버튼 (미완)
  Widget _buildSaveButtonWidget(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: MediaQuery.of(context).size.width / 2 - 120,
      child: ElevatedButton(
        onPressed: () {
          editorController.addSchedule();
          editorController.clearData();
          containerList.clear();
          lectureNameController.clear();
          professorNameController.clear();
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
          backgroundColor: MaterialStateProperty.all<Color>(Styles.actionColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.black, width: 0),
            ),
          ),
        ),
        child: Text('저장하기',style: Styles.inputFieldTextStyle.copyWith(color: Colors.white)),
      ),
    );
  }
}
