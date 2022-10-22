import 'package:simply_halal/model/business.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static const int _version = 1;
  static const String _dbName = "SimplyHalal.db";

  static final DatabaseHelper db = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => {
              await db.execute("CREATE TABLE Business "
                  "(id TEXT PRIMARY KEY,"
                  "name TEXT NOT NULL,"
                  "image_url TEXT,"
                  "rating REAL,"
                  "url TEXT,"
                  "distance REAL);")
            },
        version: _version);
  }

  Future<int> addBusiness(Business business) async {
    final db = await database;

    return await db.insert("Business", business.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Business>?> getAllBusiness() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("Business");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => Business.fromJson(maps[index]));
  }

  Future<int> deleteBusinesses() async {
    final db = await database;

    return await db.delete("Business");
  }
}
