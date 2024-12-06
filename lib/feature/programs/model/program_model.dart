import 'package:gymbro/database/db_const.dart';

class ProgramModel {
  final int? id;
  final String name;

  ProgramModel({
    this.id,
    required this.name,
  });

  // CopyWith method
  ProgramModel copyWith({
    int? id,
    String? name,
  }) =>
      ProgramModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  // FromJSON e ToJSON method
  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json[DBConst.idColPR],
        name: json[DBConst.nameColPR],
      );

  Map<String, dynamic> toJson() => {
        DBConst.idColPR: id,
        DBConst.nameColPR: name,
      }..removeWhere((key, value) => value == null);
}
