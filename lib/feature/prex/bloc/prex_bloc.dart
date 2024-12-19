import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymbro/database/app_db.dart';
import 'package:gymbro/database/db_const.dart';
import 'package:gymbro/feature/prex/model/prex_model.dart';
import 'package:sqflite/sqflite.dart';

part 'prex_event.dart';

part 'prex_state.dart';

class PrexBloc extends Bloc<PrexEvent, PrexState> {
  PrexBloc({required this.appDB}) : super(ListPrexState(prexList: [])) {
    on<CreatePrexEvent>((event, emit) async => await _createPrex(
          event,
          emit,
          event.prex,
        ));
    on<ReadPrexEvent>(
      (event, emit) async => await _readPrex(event, emit, event.programId),
    );
    on<DeletePrexEvent>(
      (event, emit) async => await _deletePrex(event, emit, event.prex),
    );

    ///on<TogglePrexEvent>(
    //       (event, emit) async => await _togglePrex(event, emit, event.prex),
    //     );
  }

  //------------------------------------------//
  createPrex({required PrexModel prex}) => add(CreatePrexEvent(prex: prex));

  readPrex({required int programId}) =>
      add(ReadPrexEvent(programId: programId));

  //updatePrex({required PrexModel prex}) => add(CreatePrexEvent(prex: prex));
  deletePrex({required PrexModel prex}) => add(DeletePrexEvent(prex: prex));

  togglePrex({required PrexModel prex}) => add(TogglePrexEvent(prex: prex));

  //------------------------------------------//
  final AppDB appDB;

  // Create Prex
  Future<void> _createPrex(
      PrexEvent event, Emitter<PrexState> emit, PrexModel prex) async {
    final db = await appDB.database;
    // Insert to DB
    await db.insert(
      DBConst.tableNamePREX,
      prex.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _readPrex(event, emit, prex.programId);
  }

// Read Prexs
  Future<void> _readPrex(
    PrexEvent event,
    Emitter<PrexState> emit,
    int programID,
  ) async {
    emit(LoadingPrexState());
    try {
      final db = await appDB.database;
      var result = await db.query(
        DBConst.tableNamePREX,
        where: '${DBConst.prIdColPREX} = ?',
        whereArgs: [programID],
      );
      List<PrexModel> prexList =
          result.map((e) => PrexModel.fromJson(e)).toList();
      emit(ListPrexState(prexList: prexList));
    } catch (e) {
      emit(ErrorPrexState(error: '$e'));
    }
  }

// Update Prex
//  Future<void> _updatePrex(PrexModel Prex) async {
//    final db = await appDB.database;
//    await db.update(
//      DBConst.tableNamePR,
//      Prex.toJson(),
//      where: '${DBConst.idColPR} = ?',
//      whereArgs: [Prex.id],
//      conflictAlgorithm: ConflictAlgorithm.replace,
//    );
//    readPrex();
//  }

  // Delete Prex
  Future<void> _deletePrex(
    PrexEvent event,
    Emitter<PrexState> emit,
    PrexModel prex,
  ) async {
    final db = await appDB.database;
    await db.delete(
      DBConst.tableNamePREX,
      where: '${DBConst.idColPREX} = ?',
      whereArgs: [prex.id],
    );
    readPrex(programId: prex.programId);
  }

  ///  // Select Prex
//   Future<void> _togglePrex(
//     PrexEvent event,
//     Emitter<PrexState> emit,
//     PrexModel prex,
//   ) async {
//     if (state is ListPrexState) {
//       final currentState = state as ListPrexState;
//       final List<PrexModel> prexList = [...currentState.prexList];
//       // If arleady contain prex, remove it. Otherwise add it
//       PrexModel test = prexList.singleWhere((e) => e.id == prex.id);
//       if (prexList.contains(test)) {
//         prexList.remove(prex);
//       } else {
//         prexList.add(prex);
//       }
//       log(prexList.toString());
//       emit(ListPrexState(prexList: prexList));
//     } else {
//       emit(ListPrexState(prexList: [prex]));
//     }
//   }
}
