import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColorMain = Color(0xfffbfbff);
  static const Color primaryColorSecondary = Color(0xfff4f6fd);

  static const Color secondaryColorMain = Color(0xff02192C);
  static const Color secondaryColorSecondary = Color(0xff0675FF);

  static const Color textColorHighEmphacy = Color(0xff020417);
  static const Color textColorMediumEmphacy = Color(0xff373b5e);
  static const Color textColorLowEmphacy = Color(0xffadbaeb);

  static const Color backgroundWhite = Color(0xfff4f6fd);
  static const Color backgroundDark = Color(0xff092033);
  static const Color backgroundCard = Color(0xff4A4A4F);
  static Color backgroundDarkCard = const Color(0xff07C6F9).withOpacity(0.04);

  static const Color stateColorFailure = Color(0xffEB5757);
}

Map<String, Color> catColors = {
  'personal': Colors.blue,
  'business': Colors.green,
  'purple': Colors.purple,
};
