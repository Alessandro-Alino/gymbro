import 'package:flutter/material.dart';

final themeLight = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green.shade100,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

final themeDark = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green.shade900,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
