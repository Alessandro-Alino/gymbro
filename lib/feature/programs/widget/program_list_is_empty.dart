import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';

class ProgramListIsEmpty extends StatefulWidget {
  const ProgramListIsEmpty({super.key});

  @override
  State<ProgramListIsEmpty> createState() => _ProgramListIsEmptyState();
}

class _ProgramListIsEmptyState extends State<ProgramListIsEmpty> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCntrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameCntrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Center(
                  child: Text(
                    context.ltr.create_first_card,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                // TextFormField for Name & Button Save
                Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionChip(
                        onPressed: () {
                          // Create first Program
                          context.read<ProgramBloc>().createProgram();
                        },
                        avatar: Icon(Icons.add),
                        label: Text(
                          context.ltr.create,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
