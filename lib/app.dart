import 'package:flutter/material.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/widget/program_list.dart';
import 'package:gymbro/widget/app_drawer.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(context.ltr.title_app),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ProgramList(),
            ),
          ],
        ),
      ),
    );
  }
}
