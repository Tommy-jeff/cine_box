import 'package:cine_box/ui/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static get theme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: AppTextStyles.semiBoldMedium.copyWith(color: Colors.black),
    ),
  );
}
