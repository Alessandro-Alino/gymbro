import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/database/app_db.dart';
import 'package:gymbro/database/db_const.dart';
import 'package:gymbro/feature/exercises/model/exercise_model.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseCubit extends Cubit<List<ExerciseModel>> {
  ExerciseCubit({required this.appDB}) : super([]);

  final AppDB appDB;

  // Create Program
  Future<void> createExercise() async {
    final db = await appDB.database;
    int index = state.length + 1;
    ExerciseModel exercise = ExerciseModel(
      name: 'Esercizio n. $index',
      descr: 'Descrizione Esercizio n. $index',
      fkProgramID: 131,
    );
    // Insert to DB
    await db.insert(
      DBConst.tableNameEX,
      exercise.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    List<ExerciseModel> exercisesList = List<ExerciseModel>.from(state);
    exercisesList.add(exercise);
    emit(exercisesList);
  }

  // Read Programs
  Future<void> readExercise() async {
    final db = await appDB.database;
    var result = await db.query(DBConst.tableNameEX);
    List<ExerciseModel> exerciseList =
        result.map((e) => ExerciseModel.fromJson(e)).toList();
    emit(exerciseList);
  }

  ///  // Update Program
//   Future<void> updateProgram(ProgramModel program) async {
//     final db = await appDB.database;
//     await db.update(
//       DBConst.tableNamePR,
//       program.toJson(),
//       where: '${DBConst.idColPR} = ?',
//       whereArgs: [program.id],
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     readProgram();
//   }

  ///  // Delete Program
//   Future<void> deleteProgram(ProgramModel program) async {
//     final db = await appDB.database;
//     await db.delete(
//       DBConst.tableNamePR,
//       where: '${DBConst.idColPR} = ?',
//       whereArgs: [program.id],
//     );
//     readProgram();
//   }
}
