import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/feature/prex/bloc/prex_bloc.dart';
import 'package:gymbro/feature/prex/model/prex_model.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
import 'package:gymbro/widget/delete_element.dart';

class PrexList extends StatelessWidget {
  const PrexList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProgramBloc, ProgramState>(
      listener: (context, state) {
        // Select the programID to GroupBy, every time is selected
        if (state.selectedProgram != null &&
            state.selectedProgram!.id != null) {
          context
              .read<PrexBloc>()
              .readPrex(programId: state.selectedProgram!.id!);
        }
      },
      child: BlocBuilder<PrexBloc, PrexState>(
        builder: (context, state) {
          if (state is LoadingPrexState) {
            return SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (state is ErrorPrexState) {
            return SliverFillRemaining(
              child: Center(
                child: Text('Attenzione generato un errore: ${state.error}'),
              ),
            );
          } else if (state is ListPrexState) {
            return state.prexList.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Text('Seleziona esercizi per questa scheda!'),
                    ),
                  )
                : SliverList.builder(
                    itemCount: state.prexList.length,
                    itemBuilder: (context, index) {
                      PrexModel prex = state.prexList[index];

                      return ListTile(
                        leading: Text('ID: ${prex.id}'),
                        title: Text('${prex.exerciseId}'),
                        trailing: DeleteElement(
                          onPressed: () {
                            context.read<PrexBloc>().deletePrex(prex: prex);
                          },
                        ),
                      );
                    });
          } else {
            return Text('Stato sconosciuto'); // Gestione di stati non previsti
          }
        },
      ),
    );
  }
}
