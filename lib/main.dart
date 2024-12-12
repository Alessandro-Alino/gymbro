import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/config/router/router.dart';
import 'package:gymbro/config/theme/cubit/theme_cubit.dart';
import 'package:gymbro/config/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymbro/database/app_db.dart';
import 'package:gymbro/feature/exercises/cubit/exercises_cubit.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDB>(create: (context) => AppDB.instance),
      ],
      child: MultiBlocProvider(
        providers: [
          // Theme Cubit
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit()..getTheme(),
          ),
          // Programs Cubit
          BlocProvider<ProgramBloc>(
            create: (context) => ProgramBloc(
              appDB: context.read<AppDB>(),
            )..readProgram(),
          ),
          // Exercise Cubit
          BlocProvider<ExerciseCubit>(
            create: (context) => ExerciseCubit(
              appDB: context.read<AppDB>(),
            )..readExercise(),
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) {
          return MaterialApp.router(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerConfig: router,
            onGenerateTitle: (context) => context.ltr.title_app,
            themeMode: themeState,
            theme: themeLight,
            darkTheme: themeDark,
          );
        },
      ),
    );
  }
}
