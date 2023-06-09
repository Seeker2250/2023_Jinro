import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_2023_project/views/mypage_screen/about_linked_account/school_account_sync_choice_.dart';
import '../../../models/linked_account_model.dart';

class LinkedAccount extends StatelessWidget {
  const LinkedAccount({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    final linkedAccountModel = Get.put<LinkedAccountModel>(LinkedAccountModel());

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('연동된 학생 계정',
            style: TextStyle(
              fontWeight : FontWeight.bold,
              fontSize: 18,
            ),),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchoolAccountSyncChoice(),
                  ),
                );
                if (result != null && result.containsKey('userEmail')) {
                  final String userEmail = result['userEmail'];
                  linkedAccountModel.setLinkedEmail(userEmail);
                }
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  height: 80,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<LinkedAccountModel>(
                        builder: (linkedAccountModel) {
                          return Text(linkedAccountModel.linkedEmail.value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
