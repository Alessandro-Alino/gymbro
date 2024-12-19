import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/feature/programs/bloc/program_bloc.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';

class ProgramDropdown extends StatefulWidget {
  const ProgramDropdown({super.key});

  @override
  State<ProgramDropdown> createState() => _ProgramDropdownState();
}

class _ProgramDropdownState extends State<ProgramDropdown> {
  final TextEditingController _dropDownCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Added short delay in initState to Set the name
    Future.delayed(Durations.short1, () => _dropDrownSetName());
  }

  @override
  void dispose() {
    super.dispose();
    _dropDownCtrl.dispose();
  }

  // When a program is selected, set the DropDown value == program.name
  _dropDrownSetName() {
    if (context.read<ProgramBloc>().state.selectedProgram != null) {
      _dropDownCtrl.text =
          context.read<ProgramBloc>().state.selectedProgram!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgramBloc, ProgramState>(
      listener: (context, state) async {
        // If program List is empty, clear the DropDown value
        if (state.programList.isEmpty) {
          _dropDownCtrl.clear();
        } else {
          _dropDrownSetName();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 16.0, bottom: 4.0),
          child: DropdownMenu<ProgramModel>(
            width: 185.0,
            menuHeight: 350.0,
            controller: _dropDownCtrl,
            enabled: state.programList.isNotEmpty,
            label: Text(context.ltr.select_program),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              isCollapsed: true,
              contentPadding: const EdgeInsets.only(left: 8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.inversePrimary,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(5, 51, 8, 1.0),
                  ),
                ),
              ),
            ),
            onSelected: (e) {
              context.read<ProgramBloc>().selectProgram(e!);
            },
            dropdownMenuEntries: [
              ...state.programList.map((program) {
                return DropdownMenuEntry<ProgramModel>(
                  value: program,
                  label: program.name,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
