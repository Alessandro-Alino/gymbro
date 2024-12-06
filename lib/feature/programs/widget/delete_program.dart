import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/feature/programs/cubit/program_cubit.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';

class DeleteProgram extends StatelessWidget {
  const DeleteProgram({super.key, required this.program});

  final ProgramModel program;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ProgramCubit>().deleteProgram(program);
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
