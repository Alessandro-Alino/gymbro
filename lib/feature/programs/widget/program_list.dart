import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/cubit/program_cubit.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';
import 'package:gymbro/feature/programs/widget/delete_program.dart';
import 'package:gymbro/feature/programs/widget/update_program.dart';

class ProgramList extends StatelessWidget {
  const ProgramList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramCubit, List<ProgramModel>>(
      builder: (context, state) {
        return state.isEmpty
            ? Center(
                child: Text(context.ltr.empty_list),
              )
            : ListView.builder(
                itemCount: state.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.length) {
                    ProgramModel program = state[index];
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        title: Text(program.name),
                        trailing: DeleteProgram(program: program),
                        onTap: () {},
                        onLongPress: () async {
                          await showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              isScrollControlled: true,
                              builder: (context) {
                                return UpdateProgram(program: program);
                              }).then(
                            (e) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                          );
                        },
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
                });
      },
    );
  }
}
