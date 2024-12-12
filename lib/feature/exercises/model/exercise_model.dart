import 'package:gymbro/database/db_const.dart';

class ExerciseModel {
  final int? id;
  final String name;
  final String descr;

  ExerciseModel({
    this.id,
    required this.name,
    required this.descr,
  });

  // CopyWith method
  ExerciseModel copyWith({
    int? id,
    String? name,
    String? descr,
  }) =>
      ExerciseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        descr: descr ?? this.descr,
      );

  // FromJSON e ToJSON method
  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
      id: json[DBConst.idColEX],
      name: json[DBConst.nameColEX],
      descr: json[DBConst.descrColEX]);

  Map<String, dynamic> toJson() => {
        DBConst.idColEX: id,
        DBConst.nameColEX: name,
        DBConst.descrColEX: descr,
      }..removeWhere((key, value) => value == null);
}
