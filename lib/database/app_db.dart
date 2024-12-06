import 'package:gymbro/database/db_const.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDB {
  static Database? _database;

  static final AppDB instance = AppDB._init();

  AppDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, DBConst.dbName);

    return await openDatabase(
      path,
      version: DBConst.dbVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Create Program Table
    await db.execute('''
      CREATE TABLE ${DBConst.tableNamePR} (
        ${DBConst.idColPR} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBConst.nameColPR} TEXT NOT NULL
      )
    ''');

    // Create Exercise Table
    await db.execute('''
      CREATE TABLE ${DBConst.tableNameEX} (
        ${DBConst.idColEX} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBConst.nameColEX} TEXT NOT NULL,
        ${DBConst.descrColEX} TEXT,
        ${DBConst.fkProgramIDColEX} INTEGER,
        FOREIGN KEY (${DBConst.fkProgramIDColEX}) REFERENCES ${DBConst.tableNamePR} (${DBConst.idColPR}) ON DELETE CASCADE
      )
    ''');
  }
  
}
