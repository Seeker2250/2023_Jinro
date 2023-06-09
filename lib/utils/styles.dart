import 'package:flutter/material.dart';

Color primary = const Color(0xff3cded7);

class Styles {
  static const EdgeInsets mainMargin = EdgeInsets.symmetric(horizontal: 20.0);
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF222969);
  static Color actionColor = const Color(0xFFF05650);
  static Color blockBackgroundColor = const Color(0xFF434343);
  static TextStyle textStyle =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500);

  static BoxDecoration contentsDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black, width: 0));

  static InputDecoration hintDeco = const InputDecoration(
      hintStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ));

  static TextStyle inputFieldTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle contentsTitleTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static EdgeInsets defaultPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0);
  static EdgeInsets mainContainerBottomMargin = const EdgeInsets.fromLTRB(0, 0, 0, 20);
}
