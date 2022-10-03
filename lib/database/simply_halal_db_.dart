import 'package:sqflite/sqflite.dart';

import '../model/business.dart';


const String tableBusiness = "business";

class BusinessDatabase {
  static final BusinessDatabase instance = BusinessDatabase._init();

  static Database? _database;

  BusinessDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('business.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const listType = 'LIST NOT NUL';
    const doubleType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''CREATE TABLE $tableBusiness (
      ${Business.rating} $doubleType,
      ${Business.phone} $textType,
      ${Business.id} $idType,
      ${Business.alias} $textType,
      ${Business.isClosed} $boolType,
      ${Business.categories} $listType,
      ${Business.name} $textType,
      ${Business.url} $textType,
      ${Business.imageUrl} $textType,
      ${Business.coordinates} $textType,
    )''');
  }

  Future<Business> create(Business business) async {
    final db = await instance.database;

    final id = await db.insert(tableBusiness, business.toJson());
    return business.copyWith(id: id);
  }

  Future<Business> readBusiness(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBusiness,
      columns: Business.,
      where: '${Business.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Business.BusinessFromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Business>> readAllBusiness() async {
    final db = await instance.database;

    const orderBy = '${Business.name} ASC';

    final result = await db.query(tableBusiness, orderBy: orderBy);

    return result.map((json) => Business.BusinessFromJson(json)).toList();
  }

  Future<int> update(Business business) async {
    final db = await instance.database;

    return db.update(
      tableBusiness,
      business.toJson(),
      where: '${Business.id} = ?',
      whereArgs: [business.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBusiness,
      where: '${Business.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
