import 'package:flutter/material.dart';

abstract class CustomTheme {
  static const Color primaryColor = const Color(0xFF8F94FB);
  static const Color primaryColorDark = const Color(0xFF4E54C8);
  static const Color screenTitleColor = const Color(0xff0C233C);
  static const Color white = const Color(0xffffffff);
  static const Color grey = const Color(0xff97AAC3);
  static const Color lightColor = const Color(0xffDBDDF4);
  static const Color redColor = const Color(0xffFF0000);
  static const Color redColorDark = const Color(0xffc62121);
  static const Color bottomNavBGColor = const Color(0xffFCFCFF);
  static const Color bottomNavTextColor = const Color(0xff97AAC3);
  static const Color overlayDark = const Color(0x208F94FB);
  static const String iosMeetingAppBarRGBAColor =
      "#908F94FB"; //transparent blue
  static const Color grey_transparent2 = const Color(0xE97C7C7C);

  static const primaryGradient = const LinearGradient(
    colors: const [primaryColor, primaryColorDark],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  //card boxShadow
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      color: overlayDark,
      offset: Offset(0.0, 3.0),
      blurRadius: 7.0,
    ),
  ];
  //icon boxShadow
  static List<BoxShadow> iconBoxShadow = [
    BoxShadow(
      color: overlayDark,
      offset: Offset(1, 6.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: overlayDark,
      offset: Offset(1, 6.0),
      blurRadius: 15.0,
    ),
  ];
  //icon boxShadow
  static List<BoxShadow> navBoxShadow = [
    BoxShadow(blurRadius: 10, color: Color(0x808F94FB), offset: Offset(1, 5))
  ];
  //card Shadow
}
