import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'schedule_editor_screen.dart';
import 'schedule_list_screen.dart';
import '../../view_models/schedule_view_widget.dart';
import '../../models/schedule_editor_controller.dart';
import '../../utils/styles.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final EditorController editorController = Get.put(EditorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: Styles.mainMargin,
        child: Center(
            child: ListView(
          children: <Widget>[
            _buildTopTitleLayout(),
            buildScheduleView(),
            _buildScheduleAddWidgetLayout(),
          ],
        )),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 수정된 부분
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      editorController.scheduleName.toString(),
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Styles.primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 30),
                    color: Styles.primaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _editScheduleNameDialogWidget();
                        },
                      );
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Icon(
                  Icons.navigate_before,
                  color: Styles.primaryColor,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleAddWidgetLayout() {
    return Container(
        height: 40,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ScheduleEditorScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Styles.primaryColor,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleListScreen(),
                ),
              );
            },
            child: Icon(
              Icons.list,
              color: Styles.primaryColor,
              size: 40,
            ),
          ),
        ]));
  }

  Widget _editScheduleNameDialogWidget() {
    final TextEditingController controller = TextEditingController();
    return AlertDialog(
      backgroundColor: Styles.blockBackgroundColor,
      title: const Text(
        '시간표 이름 설정',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: '시간표 이름을 입력하세요.',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            '취소',
            style: TextStyle(color: Styles.actionColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            '확인',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Update the schedule name and then close the dialog.
            editorController.saveScheduleNameToFirebase();
            editorController.setScheduleName(controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
