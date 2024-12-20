import 'package:flutter/material.dart';
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
    );
    // Insert to DB
    await db.insert(
      DBConst.tableNameEX,
      exercise.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    List<ExerciseModel>.from(state).add(exercise);
    await readExercise();
  }

  // Read Programs
  Future<void> readExercise() async {
    final db = await appDB.database;
    var result = await db.query(DBConst.tableNameEX);
    List<ExerciseModel> exerciseList =
        result.map((e) => ExerciseModel.fromJson(e)).toList();
    emit(exerciseList);
  }

  // Update Program
  Future<void> updateExercise(ExerciseModel exercise) async {
    final db = await appDB.database;
    await db.update(
      DBConst.tableNameEX,
      exercise.toJson(),
      where: '${DBConst.idColEX} = ?',
      whereArgs: [exercise.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await readExercise();
  }

  // Delete Program
  Future<void> deleteExercise(ExerciseModel exercise) async {
    final db = await appDB.database;
    await db.delete(
      DBConst.tableNameEX,
      where: '${DBConst.idColEX} = ?',
      whereArgs: [exercise.id],
    );
    await readExercise();
  }

  // Get Exercise
  Future<ExerciseModel> getExercise(int exerciseID) async {
    ExerciseModel exercise = await Future.delayed(
      Durations.short1,
      () => state.singleWhere((e) => e.id == exerciseID),
    );
    return exercise;
  }
}
