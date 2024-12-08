import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'costume.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE costumes (
            id INTEGER PRIMARY KEY,
            name TEXT,
            category TEXT,
            price REAL,
            size TEXT,
            material TEXT,
            color TEXT,
            stock INTEGER,
            description TEXT,
            imagePath TEXT
          )
          ''',
        );
      },
    );
  }

  Future<Map<String, dynamic>?> getCostumeById(int id) async {
    final db = await database;
    final result = await db.query(
      'costumes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null; // Return null if no data is found
  }

  Future<int> insertCostume(Map<String, dynamic> costume) async {
    final db = await database;
    return await db.insert('costumes', costume);
  }

  Future<List<Map<String, dynamic>>> fetchCostumes() async {
    final db = await database;
    return await db.query('costumes');
  }

  // Fungsi untuk menghapus kostum berdasarkan ID
  Future<int> deleteCostume(int id) async {
    final db = await database;
    return await db.delete(
      'costumes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}