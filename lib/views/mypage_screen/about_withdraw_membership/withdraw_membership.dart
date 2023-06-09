import 'package:flutter/material.dart';

class WithdrawMembership extends StatefulWidget {
  const WithdrawMembership({Key? key}) : super(key: key);

  @override
  _WithdrawMembershipState createState() => _WithdrawMembershipState();
}

class _WithdrawMembershipState extends State<WithdrawMembership> {
  bool _isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isDialogOpen = true;
            });
            _showConfirmationDialog(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
            alignment: Alignment.centerLeft,
          ),
          child: const Text(
            '회원탈퇴',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    // Reset the form values here
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('정말 탈퇴하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('예'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
              child: const Text('아니오'),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    if (_isDialogOpen) {
      // 다이얼로그가 열려있는 경우, 닫기 버튼을 통해 상태를 업데이트하고 처리 중지
      setState(() {
        _isDialogOpen = false;
      });
    }
    super.dispose();
  }
}
