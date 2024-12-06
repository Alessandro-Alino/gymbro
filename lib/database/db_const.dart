class DBConst{
  DBConst._();

  //Database
  static const dbVersion=1;
  static const dbName='gymbroDB.db';

  // Table Programs = PR
  static const tableNamePR='programs_table';
  static const idColPR='id';
  static const nameColPR='name';

  // Table Exercise = EX
  static const tableNameEX='exercises_table';
  static const idColEX='id';
  static const nameColEX='name';
  static const descrColEX='description';
  static const fkProgramIDColEX='program_id';
}
