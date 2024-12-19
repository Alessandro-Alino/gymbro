import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/exercises/cubit/exercises_cubit.dart';
import 'package:gymbro/feature/exercises/model/exercise_model.dart';
import 'package:gymbro/widget/delete_element.dart';
import 'package:gymbro/widget/dialog_update.dart';

class AllExerciseList extends StatelessWidget {
  const AllExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, List<ExerciseModel>>(
      builder: (context, state) {
        return state.isEmpty
            ? Center(child: Text(context.ltr.empty_list))
            : ListView.builder(
                itemCount: state.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.length) {
                    ExerciseModel exercise = state[index];
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        trailing: DeleteElement(
                          onPressed: () {
                            context
                                .read<ExerciseCubit>()
                                .deleteExercise(exercise);
                          },
                        ),
                        onLongPress: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogUpdate(
                                  name: exercise.name,
                                  onSave: (newName) async {
                                    // Update Exercise
                                    ExerciseModel updatedExercise =
                                        exercise.copyWith(name: newName);
                                    // Update DB
                                    await context
                                        .read<ExerciseCubit>()
                                        .updateExercise(updatedExercise);
                                  },
                                );
                              });
                        },
                        title: Text(exercise.name),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Divider(height: 16.0),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.ltr.title_app),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
      },
    );
  }
}
