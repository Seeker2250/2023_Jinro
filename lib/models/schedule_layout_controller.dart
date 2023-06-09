import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'schedule_editor_controller.dart';


class ScheduleLayoutController extends GetxController {
  EditorController editorController = Get.find();


  List<Widget> buildScheduleContainers(int index) {
    RxList<Widget> scheduleContainers = <Widget>[].obs;
    scheduleContainers.clear();

    if (editorController.getSelectedDaysMapKeys().isNotEmpty) {
      List<int> selectedDayMapKeys = editorController.getSelectedDaysMapKeys();
      for (int containerId in selectedDayMapKeys) {
        if (_getDayIndex(
                editorController.getSelectedDayMapValue(containerId)) ==
            index) {
          scheduleContainers.add(
              _buildPositionedLectureContainer(containerId, editorController));
        }
      }
    }

    scheduleContainers.refresh();
    if (scheduleContainers.isNotEmpty) {
      return scheduleContainers;
    } else {
      return [Container()];
    }
  }

  Widget _buildPositionedLectureContainer(int index, EditorController eC) {
    return Obx(() {
      if (eC.getSelectedStartTimeValue(index).hour >= 9 ||
          eC.getSelectedEndTimeValue(index).hour <= 20) {
        return Positioned(
          top: 20 +
              (eC.getSelectedStartTimeValue(index).hour - 9) * 52 +
              (eC.getSelectedStartTimeValue(index).minute * 52 / 60),
          height: eC
                  .getSelectedEndTimeValue(index)
                  .difference(eC.getSelectedStartTimeValue(index))
                  .inMinutes *
              52 /
              60,
          width: 100,
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  int _getDayIndex(String day) {
    switch (day) {
      case '월요일': return 0;
      case '화요일': return 1;
      case '수요일': return 2;
      case '목요일': return 3;
      case '금요일': return 4;
      default: return -1;
    }
  }
}
