import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();

  static DatabaseHelper get instance => _instance;

  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = await getDatabasesPath();
    final String databasePath = join(path, 'todo_database.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE todo_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            isCompleted INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<void> insertToDoItem(Map<String, dynamic> row) async {
    final Database db = await instance.database;
    await db.insert('todo_items', row);
  }

  Future<List<Map<String, dynamic>>> queryAllToDoItems() async {
    final Database db = await instance.database;
    return await db.query('todo_items');
  }

  Future<void> updateToDoItem(Map<String, dynamic> row) async {
    final Database db = await instance.database;
    final int id = row['id'];
    await db.update(
      'todo_items',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteToDoItem(int id) async {
    final Database db = await instance.database;
    await db.delete(
      'todo_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
