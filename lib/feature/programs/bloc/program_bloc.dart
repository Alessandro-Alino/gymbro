import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/database/app_db.dart';
import 'package:gymbro/database/db_const.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';
import 'package:sqflite/sqflite.dart';

part 'program_event.dart';

part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  ProgramBloc({required this.appDB})
      : super(ProgramState(
          programList: [],
          selectedProgram: null,
        )) {
    on<CreateProgramEvent>(
      (event, emit) async => await _createProgram(event, emit),
    );
    on<ReadProgramEvent>(
      (event, emit) async => await _readProgram(event, emit),
    );
    on<UpdateProgramEvent>(
      (event, emit) async => await _updateProgram(event.program),
    );
    on<DeleteProgramEvent>(
      (event, emit) async => await _deleteProgram(event.program),
    );
    on<SelectProgramEvent>((event, emit) async => await _selectProgram(
          event,
          emit,
          event.program,
        ));
  }

  //------------------------------------------//
  createProgram() => add(CreateProgramEvent());

  readProgram() => add(ReadProgramEvent());

  updateProgram(ProgramModel program) {
    add(UpdateProgramEvent(program: program));
  }

  deleteProgram(ProgramModel program) {
    add(DeleteProgramEvent(program: program));
  }

  selectProgram(ProgramModel? program) {
    add(SelectProgramEvent(program: program));
  }

  unSelectProgram() => add(UnSelectProgramEvent());

  //------------------------------------------//
  final AppDB appDB;

  // Create Program
  Future<void> _createProgram(
    ProgramEvent event,
    Emitter<ProgramState> emit,
  ) async {
    final db = await appDB.database;

    int index = state.programList.length + 1;
    ProgramModel program = ProgramModel(name: 'Scheda n. $index');

    // Insert to DB
    await db.insert(
      DBConst.tableNamePR,
      program.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    List<ProgramModel>.from(state.programList).add(program);
    await _readProgram(event, emit);
  }

// Read Programs
  Future<void> _readProgram(
    ProgramEvent event,
    Emitter<ProgramState> emit,
  ) async {
    final db = await appDB.database;
    var result = await db.query(DBConst.tableNamePR);
    List<ProgramModel> programList =
        result.map((e) => ProgramModel.fromJson(e)).toList();
    emit(state.copyWith(
      programList: programList,
      selectedProgram: state.selectedProgram,
    ));
    // If it's the first Program, select by [_selectProgram]
    if (state.programList.length == 1) {
      selectProgram(state.programList.first);
    } else if (state.programList.isEmpty) {
      selectProgram(null);
    }
  }

// Update Program
  Future<void> _updateProgram(ProgramModel program) async {
    final db = await appDB.database;
    await db.update(
      DBConst.tableNamePR,
      program.toJson(),
      where: '${DBConst.idColPR} = ?',
      whereArgs: [program.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    readProgram();
  }

// Delete Program
  Future<void> _deleteProgram(ProgramModel program) async {
    final db = await appDB.database;
    await db.delete(
      DBConst.tableNamePR,
      where: '${DBConst.idColPR} = ?',
      whereArgs: [program.id],
    );
    readProgram();
  }

  // Select Program
  Future<void> _selectProgram(
    ProgramEvent event,
    Emitter<ProgramState> emit,
    ProgramModel? program,
  ) async {
    program == null
        ? emit(state.copyWith(selectedProgram: null))
        : emit(state.copyWith(selectedProgram: program));
  }
}
