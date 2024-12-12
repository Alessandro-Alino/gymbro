import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
import 'package:gymbro/feature/programs/widget/program_list_is_empty.dart';
import 'package:gymbro/widget/add_exer_to_progr.dart';
import 'package:gymbro/widget/app_drawer.dart';
import 'package:gymbro/widget/custom_flexible_spacebar.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            pinned: true,
            title: Text(context.ltr.title_app),
            expandedHeight: 300.0,
            flexibleSpace: CustomFlexibleSpaceBar(),
          ),
          // Content
          BlocBuilder<ProgramBloc, ProgramState>(builder: (context, state) {
            return state.programList.isEmpty
                // If ProgramList is Empty
                ? ProgramListIsEmpty()
                // List of Exercises per Selected Program
                : SliverFillRemaining(
                    child: Center(
                      child: Text('Arrivo ...'),
                    ),
                  );
          }),
        ],
      ),
      floatingActionButton:
          BlocBuilder<ProgramBloc, ProgramState>(builder: (context, state) {
        return state.selectedProgram == null
            ? SizedBox()
            : FloatingActionButton.extended(
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      isScrollControlled: true,
                      builder: (context) {
                        return AddExerToProgr();
                      });
                },
                label: const Text('Add exercise'),
                icon: const Icon(Icons.add),
              );
      }),
    );
  }
}
