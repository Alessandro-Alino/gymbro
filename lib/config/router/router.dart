import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/app.dart';
import 'package:gymbro/config/router/router_const.dart';
import 'package:gymbro/feature/exercises/screen/exercise_list_page.dart';
import 'package:gymbro/feature/programs/screen/program_list_page.dart';

final goRouterKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: goRouterKey,
  debugLogDiagnostics: true,
  initialLocation: startPage,
  routes: [
    GoRoute(
      path: startPage,
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      },
    ),
    GoRoute(
      path: programListPage,
      builder: (BuildContext context, GoRouterState state) {
        return const ProgramListPage();
      },
    ),
    GoRoute(
      path: exerciseListPage,
      builder: (BuildContext context, GoRouterState state) {
        return const ExerciseListPage();
      },
    ),
  ],
);

///GoRoute(
//         path: categPage,
//         builder: (BuildContext context, GoRouterState state) {
//           return const CategPage();
//         },
//         routes: [
//           GoRoute(
//             path: mngCategoriesPage,
//             pageBuilder: (context, state) {
//               final Categories? data =
//               state.extra == null ? null : state.extra as Categories;
//               return CustomTransitionPage(
//                 transitionDuration: const Duration(milliseconds: 600),
//                 transitionsBuilder: (_, __, ___, Widget child) => child,
//                 child: ManageCategoriesPage(category: data),
//               );
//             },
//           ),
//         ]),

///pageBuilder: (context, state) {
//             //
//             //  return CustomTransitionPage(
//             //    fullscreenDialog: true,
//             //    opaque: false,
//             //    transitionsBuilder: (context, animation, ___, Widget child) {
//             //      const begin = Offset(0.0, 1.0);
//             //      const end = Offset.zero;
//             //      final tween = Tween(begin: begin, end: end);
//             //      final offsetAnimation = animation.drive(tween);
//             //      return SlideTransition(
//             //        position: offsetAnimation,
//             //        child: FadeTransition(
//             //          opacity: animation,
//             //          child: child,
//             //        ),
//             //      );
//             //    },
//             //    child: ,
//             //  );
//             //},
