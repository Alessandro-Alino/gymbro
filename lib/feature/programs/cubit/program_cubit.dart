import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/database/app_db.dart';
import 'package:gymbro/database/db_const.dart';
import 'package:gymbro/feature/programs/model/program_model.dart';
import 'package:sqflite/sqflite.dart';

class ProgramCubit extends Cubit<List<ProgramModel>> {
  ProgramCubit({required this.appDB}) : super([]);

  final AppDB appDB;

  // Create Program
  Future<void> createProgram() async {
    final db = await appDB.database;
    int index = state.length + 1;
    ProgramModel program = ProgramModel(name: 'Scheda n. $index');
    // Insert to DB
    await db.insert(
      DBConst.tableNamePR,
      program.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    List<ProgramModel> programList = List<ProgramModel>.from(state);
    programList.add(program);
    emit(programList);
  }

  // Read Programs
  Future<void> readProgram() async {
    final db = await appDB.database;
    var result = await db.query(DBConst.tableNamePR);
    List<ProgramModel> programList =
        result.map((e) => ProgramModel.fromJson(e)).toList();
    emit(programList);
  }

  // Update Program
  Future<void> updateProgram(ProgramModel program) async {
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
  Future<void> deleteProgram(ProgramModel program) async {
    final db = await appDB.database;
    await db.delete(
      DBConst.tableNamePR,
      where: '${DBConst.idColPR} = ?',
      whereArgs: [program.id],
    );
    readProgram();
  }
}
