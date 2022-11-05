import 'package:simply_halal/model/business.dart';
import 'package:simply_halal/model/favorite_model.dart';
import 'package:simply_halal/model/search_model.dart';
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
    return await openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: _createDB, version: _version);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("CREATE TABLE Business "
        "(id TEXT PRIMARY KEY,"
        "name TEXT NOT NULL,"
        "image_url TEXT,"
        "rating REAL,"
        "url TEXT,"
        "distance REAL);");

    await db.execute("CREATE TABLE Favorite_Business "
        "(id TEXT PRIMARY KEY,"
        "name TEXT NOT NULL,"
        "image_url TEXT,"
        "distance REAL);");

    await db.execute("CREATE TABLE Search_Business "
        "(id TEXT PRIMARY KEY,"
        "name TEXT NOT NULL,);");
  }

  // Businesses
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

  // Favorite Model
  Future<int> addFavorite(FavoriteModel favorite) async {
    final db = await database;

    return await db.insert("Favorite_Business", favorite.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteFavorite(FavoriteModel favorite) async {
    final db = await database;

    return await db.delete("Favorite_Business",
        where: 'name = ?', whereArgs: [favorite.businessName]);
  }

  Future<FavoriteModel?> getFavoriteBusiness(
      FavoriteModel favoriteModel) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("Favorite_Business",
        where: 'name = ?', whereArgs: [favoriteModel.businessName]);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => FavoriteModel.fromJson(maps[index]))[0];
  }

  Future<List<FavoriteModel>?> getAllFavorites() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("Favorite_Business");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => FavoriteModel.fromJson(maps[index]));
  }

  // Search Model
  Future<int> addSearch(SearchModel search) async {
    final db = await database;

    return await db.insert("Search_Business", search.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteSearch(SearchModel search) async {
    final db = await database;

    return await db.delete("Search_Business",
        where: 'name = ?', whereArgs: [search.businessName]);
  }

  Future<SearchModel?> getSearchBusiness(SearchModel searchModel) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("Search_Business",
        where: 'name = ?', whereArgs: [searchModel.businessName]);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => SearchModel.fromJson(maps[index]))[0];
  }

  Future<List<SearchModel>?> getAllSearchs() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("Search_Business");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => SearchModel.fromJson(maps[index]));
  }
}
