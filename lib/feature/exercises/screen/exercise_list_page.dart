import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/exercises/cubit/exercises_cubit.dart';
import 'package:gymbro/feature/exercises/widget/exercise_list.dart';

class AllExerciseListPage extends StatefulWidget {
  const AllExerciseListPage({super.key});

  @override
  State<AllExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<AllExerciseListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseCubit>().readExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ltr.exercise_list_page),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AllExerciseList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<ExerciseCubit>().createExercise();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
