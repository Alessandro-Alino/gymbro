import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/config/theme/cubit/theme_cubit.dart';
import 'package:gymbro/feature/exercises/cubit/exercises_cubit.dart';
import 'package:gymbro/feature/exercises/model/exercise_model.dart';
import 'package:gymbro/feature/programs/widget/program_dropdown.dart';

class AddExerToProgr extends StatelessWidget {
  const AddExerToProgr({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      initialChildSize: 0.5,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Title
                    Flexible(
                      flex: 1,
                      child: Text(
                        'Scheda selezionata:',
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
                const Divider(),
                Row(
                  children: [
                    Text(
                      'Aggiungi esercizi:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
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
                              return Card(
                                color: context
                                    .read<ThemeCubit>()
                                    .isLightTheme(MediaQuery.of(context).platformBrightness)
                                    ? Colors.green.shade100
                                    : Colors.green.shade900,
                                child: ListTile(
                                  title: Text(exercise.name),
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
