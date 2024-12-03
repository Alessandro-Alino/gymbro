import 'package:flutter/material.dart';
import 'package:gymbro/config/router/router.dart';
import 'package:gymbro/config/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      title: 'Flutter Demo',
      theme: themeLight,
      darkTheme: themeDark,
    );
  }
}

