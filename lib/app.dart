import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
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
          SliverAppBar(
            pinned: true,
            title: Text(context.ltr.title_app),
            expandedHeight: 300.0,
            flexibleSpace: CustomFlexibleSpaceBar(),
          ),
          SliverFillRemaining(
            child: Center(
              child: BlocBuilder<ProgramBloc, ProgramState>(
                builder: (context, state) {
                  return Text(state.selectedProgram == null
                      ? 'Nessuna selezione'
                      : state.selectedProgram!.name);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
