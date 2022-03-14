import 'package:flutter/material.dart';

class GitlabColors {
  GitlabColors._();

  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

  static const MaterialColor grey = MaterialColor(
    0xff999999,
    <int, Color>{
      10: Color(0xff1f1f1f),
      50: Color(0xff303030),
      100: Color(0xff404040),
      200: Color(0xff525252),
      300: Color(0xff5e5e5e),
      400: Color(0xff868686),
      500: Color(0xff999999),
      600: Color(0xffbfbfbf),
      700: Color(0xffdbdbdb),
      800: Color(0xfff0f0f0),
      900: Color(0xfffafafa),
      950: Color(0xffffffff),
    },
  );

  static const MaterialColor orange = MaterialColor(
    0xffc17d10,
    <int, Color>{
      50: Color(0xff5c2900),
      100: Color(0xff703800),
      200: Color(0xff8f4700),
      300: Color(0xff9e5400),
      400: Color(0xffab6100),
      500: Color(0xffc17d10),
      600: Color(0xffd99530),
      700: Color(0xffe9be74),
      800: Color(0xfffdd4cd),
      900: Color(0xfffcf1ef),
      950: Color(0xfffff4f3),
    },
  );

  static const MaterialColor red = MaterialColor(
    0xffec5941,
    <int, Color>{
      50: Color(0xff660e00),
      100: Color(0xff9d1300),
      200: Color(0xffae1800),
      300: Color(0xffc91c00),
      400: Color(0xffdd2b0e),
      500: Color(0xffec5941),
      600: Color(0xfff57f6c),
      700: Color(0xfffcb5aa),
      800: Color(0xfffdd4cd),
      900: Color(0xfffcf1ef),
      950: Color(0xfffff4f3),
    },
  );

  static const MaterialColor green = MaterialColor(
    0xff2da160,
    <int, Color>{
      50: Color(0xff0a4020),
      100: Color(0xff0d532a),
      200: Color(0xff24663b),
      300: Color(0xff217645),
      400: Color(0xff108548),
      500: Color(0xff2da160),
      600: Color(0xff52b87a),
      700: Color(0xff91d4a8),
      800: Color(0xffc3e6cd),
      900: Color(0xffecf4ee),
      950: Color(0xfff1fdf6),
    },
  );
}

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: GitlabColors.orange,
  scaffoldBackgroundColor: GitlabColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: GitlabColors.grey[800],
    elevation: 0,
    foregroundColor: GitlabColors.black,
  ),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      fontSize: 18,
    ),
    bodyMedium: const TextStyle(color: GitlabColors.black),
    bodySmall: TextStyle(
      color: GitlabColors.grey[300],
    ),
  ),
  dividerColor: GitlabColors.grey[700],
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: GitlabColors.orange,
  scaffoldBackgroundColor: GitlabColors.grey[10],
  appBarTheme: AppBarTheme(
    backgroundColor: GitlabColors.grey[50],
    elevation: 0,
  ),
  textTheme: TextTheme(
    titleMedium: const TextStyle(
      fontSize: 18,
      color: GitlabColors.white,
    ),
    bodyMedium: const TextStyle(color: GitlabColors.white),
    bodySmall: TextStyle(
      color: GitlabColors.grey[500],
    ),
  ),
  iconTheme: const IconThemeData(color: GitlabColors.white),
  dividerColor: GitlabColors.grey[200],
);
