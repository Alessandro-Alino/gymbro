import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/config/theme/cubit/theme_cubit.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ltr.title_app),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            context.read<ThemeCubit>().setTheme(ThemeMode.light);
          },
          child: Text(context.ltr.yes),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ThemeCubit>().setTheme(ThemeMode.dark);
          },
          child: Text(context.ltr.yes),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ThemeCubit>().setTheme(ThemeMode.system);
          },
          child: Text(context.ltr.yes),
        ),
      ]),
    );
  }
}
