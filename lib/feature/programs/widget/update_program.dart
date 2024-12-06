import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/cubit/program_cubit.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';

class UpdateProgram extends StatefulWidget {
  const UpdateProgram({super.key, required this.program});

  final ProgramModel program;

  @override
  State<UpdateProgram> createState() => _UpdateProgramState();
}

class _UpdateProgramState extends State<UpdateProgram> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final programCntrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    programCntrl.text = widget.program.name;
  }

  @override
  void dispose() {
    super.dispose();
    programCntrl.dispose();
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
              controller: programCntrl,
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
                      ProgramModel program = widget.program.copyWith(
                        name: programCntrl.text,
                      );
                      // Update DB
                      await context.read<ProgramCubit>().updateProgram(program);
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
