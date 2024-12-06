import 'package:gymbro/database/db_const.dart';

class ExerciseModel {
  final int? id;
  final String name;
  final String descr;
  final int fkProgramID;

  ExerciseModel({
    this.id,
    required this.name,
    required this.descr,
    required this.fkProgramID,
  });

  // CopyWith method
  ExerciseModel copyWith({
    int? id,
    String? name,
    String? descr,
    int? fkProgramID,
  }) =>
      ExerciseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        descr: descr ?? this.descr,
        fkProgramID: fkProgramID ?? this.fkProgramID,
      );

  // FromJSON e ToJSON method
  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
      id: json[DBConst.idColEX],
      name: json[DBConst.nameColEX],
      descr: json[DBConst.descrColEX],
      fkProgramID: json[DBConst.fkProgramIDColEX]);

  Map<String, dynamic> toJson() => {
        DBConst.idColEX: id,
        DBConst.nameColEX: name,
        DBConst.descrColEX: descr,
        DBConst.fkProgramIDColEX: fkProgramID,
      }..removeWhere((key, value) => value == null);
}
