class DBConst{
  DBConst._();

  //Database
  static const int dbVersion=1;
  static const String dbName='gymbroDB.db';

  // Table Programs = PR
  static const String tableNamePR='programs_table';
  static const String idColPR='id';
  static const String nameColPR='name';

  // Table Exercise = EX
  static const String tableNameEX='exercises_table';
  static const String idColEX='id';
  static const String nameColEX='name';
  static const String descrColEX='description';
  static const String fkProgramIDColEX='program_id';

  // Table ForeignKey PR -> List of EX
  static const String tableNamePREX='prog_exer_table';
  static const String idColPREX='id';
  static const String prIdColPREX='program_id';
  static const String exIdColPREX='exercise_id';
  static const String setsColPREX='sets';
  static const String repsColPREX='reps';
  static const String weightColPREX='weight';
}
