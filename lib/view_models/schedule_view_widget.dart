import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/schedule_editor_controller.dart';
import '../models/schedule_layout_controller.dart';



List week = ['월', '화', '수', '목', '금'];
var scheduleColumnLength = 22;
double firstBoxHeight = 20;
double scheduleBoxSize = 52;

Widget buildScheduleView() {
  Get.put(EditorController());
  ScheduleLayoutController scheduleLayoutModel = Get.put(ScheduleLayoutController());

  return Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    height: scheduleColumnLength / 2 * scheduleBoxSize + scheduleColumnLength,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        _buildScheduleTimeColumn(),
        for (var i = 0; i < 5; i++) ...[
          const VerticalDivider(
            color: Colors.grey,
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: _buildDayColumnBorder(i, scheduleLayoutModel),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _buildScheduleTimeColumn() {
  return Expanded(
    flex: 1,
    child: Column(
      children: [
        SizedBox(height: firstBoxHeight),
        ...List.generate(
            scheduleColumnLength,
            (index) => (index % 2 == 0)
                ? const Divider(color: Colors.grey, height: 0)
                : SizedBox(
                    height: scheduleBoxSize,
                    child:
                        Text('${index ~/ 2 + 9}', textAlign: TextAlign.start),
                  )),
      ],
    ),
  );
}

List<Widget> _buildDayColumnBorder(int index, ScheduleLayoutController scheduleLayoutModel) {
  return [
    Obx(() {
      final scheduleContainers =
      scheduleLayoutModel.buildScheduleContainers(index);
      return Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: firstBoxHeight,
                child: Text('${week[index]}'),
              ),
              ...List.generate(
                scheduleColumnLength,
                    (innerIndex) => innerIndex % 2 == 0
                    ? const Divider(color: Colors.grey, height: 0)
                    : SizedBox(
                  height: scheduleBoxSize,
                  child: Container(),
                ),
              ),
            ],
          ),
          ...scheduleContainers,
        ],
      );
    }),
  ];
}
