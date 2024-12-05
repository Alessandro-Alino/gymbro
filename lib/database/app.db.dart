import 'package:gymbro/database/db_const.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;


  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/${DBConst.dbName}';

    return await openDatabase(
      path,
      version: DBConst.dbVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        muscle_group TEXT NOT NULL,
        sets INTEGER,
        reps INTEGER,
        notes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        day TEXT NOT NULL,
        exercise_ids TEXT NOT NULL
      )
    ''');
  }
  //Future<int> insertExercise(Exercise exercise) async {
  //  final db = await database;
  //  return await db.insert('exercises', exercise.toMap());
  //}
}