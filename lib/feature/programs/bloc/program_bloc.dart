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
    on<CreateProgramEvent>((event, emit) => _createProgram());
    on<ReadProgramEvent>((event, emit) => _readProgram(event, emit));
    on<UpdateProgramEvent>((event, emit) => _updateProgram(event.program));
    on<DeleteProgramEvent>((event, emit) => _deleteProgram(event.program));
    on<SelectProgramEvent>((event, emit) => _selectProgram(
          event,
          emit,
          event.program,
        ));
    on<UnSelectProgramEvent>((event, emit) => _unSelectProgram(event, emit));
  }

  createProgram() => add(CreateProgramEvent());

  readProgram() => add(ReadProgramEvent());

  updateProgram(ProgramModel program) {
    add(UpdateProgramEvent(program: program));
  }

  deleteProgram(ProgramModel program) {
    add(DeleteProgramEvent(program: program));
  }

  selectProgram(ProgramModel program) {
    add(SelectProgramEvent(program: program));
  }

  unSelectProgram() => add(UnSelectProgramEvent());

  final AppDB appDB;

  // Create Program
  Future<void> _createProgram() async {
    final db = await appDB.database;

    int index = state.programList.length + 1;
    ProgramModel program = ProgramModel(name: 'Scheda n. $index');

    // Insert to DB
    await db.insert(
      DBConst.tableNamePR,
      program.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    List<ProgramModel> programList = List<ProgramModel>.from(state.programList);
    programList.add(program);

    readProgram();
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
    emit(state.copyWith(programList: programList));
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
  void _selectProgram(
    ProgramEvent event,
    Emitter<ProgramState> emit,
    ProgramModel program,
  ) async {
    emit(state.copyWith(selectedProgram: program));
  }

  //_unSelectProgram
  _unSelectProgram(ProgramEvent event, Emitter<ProgramState> emit) {
    emit(state.copyWith(selectedProgram: null));
  }
}
