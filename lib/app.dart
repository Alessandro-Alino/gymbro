import 'package:flutter/material.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/widget/app_drawer.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(context.ltr.title_app),
      ),
      body: Center(
        child: Text(context.ltr.title_app),
      ),
    );
  }
}
