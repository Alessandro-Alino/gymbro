import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/config/theme/cubit/theme_cubit.dart';
import 'package:gymbro/feature/exercises/cubit/exercises_cubit.dart';
import 'package:gymbro/feature/exercises/model/exercise_model.dart';
import 'package:gymbro/feature/prex/bloc/prex_bloc.dart';
import 'package:gymbro/feature/prex/model/prex_model.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
import 'package:gymbro/feature/programs/widget/program_dropdown.dart';

class AddExerToProgr extends StatelessWidget {
  const AddExerToProgr({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      initialChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: context
                    .read<ThemeCubit>()
                    .isLightTheme(MediaQuery.platformBrightnessOf(context))
                ? Color.fromRGBO(181, 214, 166, 1.0)
                : Color.fromRGBO(34, 46, 34, 1.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                // Drag Handle
                Icon(Icons.horizontal_rule_rounded, size: 40.0),
                // Title & DropDown
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Title
                        Flexible(
                          flex: 1,
                          child: Text(
                            'Scheda:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        // DropDown to Select the Program
                        Flexible(
                          flex: 2,
                          child: ProgramDropdown(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Title: "Add Exercises"
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '${context.ltr.add_exercises}:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                // List of Exercises
                BlocBuilder<ExerciseCubit, List<ExerciseModel>>(
                  builder: (context, state) {
                    return state.isEmpty
                        ? Center(child: Text(context.ltr.empty_list))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              ExerciseModel exercise = state[index];
                              return GestureDetector(
                                onTap: () {
                                  PrexModel prex = PrexModel(
                                    programId: context
                                        .read<ProgramBloc>()
                                        .state
                                        .selectedProgram!
                                        .id!,
                                    exerciseId: exercise.id!,
                                    sets: 3,
                                    reps: 12,
                                    weight: 65.5,
                                  );
                                  context
                                      .read<PrexBloc>()
                                      .createPrex(prex: prex);
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(exercise.name),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
