import 'package:flutter/material.dart';

final themeLight = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green.shade500,
    brightness: Brightness.light,
  ),
);

final themeDark = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green.shade800,
    brightness: Brightness.dark,
  ),
);
