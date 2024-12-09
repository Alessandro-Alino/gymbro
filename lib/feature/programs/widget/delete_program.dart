import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';

class DeleteProgram extends StatelessWidget {
  const DeleteProgram({super.key, required this.program});

  final ProgramModel program;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ProgramBloc>().deleteProgram(program);
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
