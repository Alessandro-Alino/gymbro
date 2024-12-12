import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/exercises/cubit/exercises_cubit.dart';
import 'package:gymbro/feature/exercises/model/exercise_model.dart';

class UpdateExercise extends StatefulWidget {
  const UpdateExercise({super.key, required this.exercise});

  final ExerciseModel exercise;

  @override
  State<UpdateExercise> createState() => _UpdateExerciseState();
}

class _UpdateExerciseState extends State<UpdateExercise> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _exerciseCntrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _exerciseCntrl.text = widget.exercise.name;
  }

  @override
  void dispose() {
    super.dispose();
    _exerciseCntrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
      BoxConstraints(minHeight: MediaQuery.sizeOf(context).height / 2),
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Text(
                    context.ltr.update_name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            // TextFormField to change name of the Program
            TextFormField(
              autofocus: true,
              controller: _exerciseCntrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (e){
                if(e!.isEmpty){
                  return context.ltr.cant_be_empty;
                }
                return null;
              },
            ),
            // Button to Save
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionChip(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      // Update program
                      ExerciseModel exercise = widget.exercise.copyWith(
                        name: _exerciseCntrl.text,
                      );
                      // Update DB
                      await context.read<ExerciseCubit>().updateExercise(exercise);
                      // Close Modal and hide keyboard
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  },
                  label: Text(context.ltr.save),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
