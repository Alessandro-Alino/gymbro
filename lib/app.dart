import 'package:flutter/material.dart';
import 'package:gymbro/config/l10n/app_local.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ltr.title_app),
      ),
    );
  }
}
