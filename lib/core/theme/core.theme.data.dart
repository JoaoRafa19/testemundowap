import 'package:flutter/material.dart';
import 'package:testemundowap/core/theme/core.theme.colors.dart';

class AppTheme extends Theme {
  const AppTheme({super.key, required super.data, required super.child});

  static const TextStyle header = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColors.white,
  );
  static const TextStyle body = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle inputLabelStyke = TextStyle(
    color: Colors.grey[400],
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextTheme textTheme = TextTheme(
    titleLarge: header,
    displayMedium: TextStyle(
        color: AppColors.lightGrey, fontSize: 20, fontWeight: FontWeight.w600),
    displaySmall: TextStyle(
        color: AppColors.lightGrey, fontSize: 12, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(
        color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w300),
    titleSmall: TextStyle(
        color: AppColors.lightGrey,
        fontSize: 20,
        fontWeight: FontWeight.w100,
        wordSpacing: 0.2),
    bodyLarge: body,
    bodyMedium: TextStyle(
        color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(
        color: AppColors.lightGrey, fontSize: 12, fontWeight: FontWeight.w600),
  );
}
