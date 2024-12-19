import 'package:gymbro/database/db_const.dart';

class PrexModel {
  final int? id;
  final int programId;
  final int exerciseId;
  final int sets;
  final int reps;
  final double weight;

  PrexModel({
    this.id,
    required this.programId,
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  // CopyWith method
  PrexModel copyWith({
    int? id,
    int? programId,
    int? exerciseId,
    int? sets,
    int? reps,
    double? weight,
  }) =>
      PrexModel(
        id: id ?? this.id,
        programId: programId ?? this.programId,
        exerciseId: exerciseId ?? this.exerciseId,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        weight: weight ?? this.weight,
      );

  // FromJSON e ToJSON method
  factory PrexModel.fromJson(Map<String, dynamic> json) => PrexModel(
        id: json[DBConst.idColPREX],
        programId: json[DBConst.prIdColPREX],
        exerciseId: json[DBConst.exIdColPREX],
        sets: json[DBConst.setsColPREX],
        reps: json[DBConst.repsColPREX],
        weight: json[DBConst.weightColPREX],
      );

  Map<String, dynamic> toJson() => {
        DBConst.idColEX: id,
        DBConst.prIdColPREX: programId,
        DBConst.exIdColPREX: exerciseId,
        DBConst.setsColPREX: sets,
        DBConst.repsColPREX: reps,
        DBConst.weightColPREX: weight,
      }..removeWhere((key, value) => value == null);
}
