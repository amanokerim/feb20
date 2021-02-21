import 'package:feb20/data/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class Dtbase {
  static final String _dbName = "feb20.db";
  static final int _dbVersion = 1;
  static final String _tableName = "tasks";

  Dtbase._privateConstructor();
  static final Dtbase instance = Dtbase._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute("""CREATE TABLE IF NOT EXISTS $_tableName (
          id INTEGER PRIMARY KEY,
          time TEXT,
          title TEXT,
          status INTEGER
          )""");
      },
    );
  }

  Future<List<Map<String, dynamic>>> getTasks({int status}) async {
    Database db = await instance.database;
    if (status == null) // get all tasks
      return db.query(_tableName);
    else // get by status
      return db.query(_tableName, where: "status=?", whereArgs: [status]);
  }

  Future<int> insert(Task task) async {
    Database db = await instance.database;
    Map<String, dynamic> values = {
      "title": task.title,
      "time": task.time,
      "status": 0,
    };
    return await db.insert(_tableName, values);
  }

  Future<int> edit(Task task) async {
    Database db = await instance.database;
    Map<String, dynamic> values = {
      "title": task.title,
      "time": task.time,
      "status": task.status,
    };
    return await db.update(
      _tableName,
      values,
      where: "id=?",
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: "id=?", whereArgs: [id]);
  }
}
