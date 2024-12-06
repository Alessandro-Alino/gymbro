import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/cubit/program_cubit.dart';
import 'package:gymbro/feature/programs/widget/program_list.dart';

class ProgramListPage extends StatelessWidget {
  const ProgramListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ltr.program_list_page),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ProgramList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<ProgramCubit>().createProgram();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
