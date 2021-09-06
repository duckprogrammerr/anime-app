import 'package:flutter/material.dart';
import 'colors.dart';

class ApptextStyle {
  static const TextStyle MY_ANIME_TITLE = TextStyle(
      color: kPrimaryColor, fontWeight: FontWeight.w700, fontSize: 16);

  static const TextStyle MY_ANIME_SUBTITLE = TextStyle(
      color: kSecondaryColor, fontWeight: FontWeight.w700, fontSize: 14);
  static const TextStyle BODY_TEXT = TextStyle(
      color: kSecondaryColor, fontWeight: FontWeight.w700, fontSize: 20);
  // ignore: non_constant_identifier_names
  static ButtonStyle BUTTON_STYLE = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      Color(0xffFF6B6B),
    ),
  );
}
