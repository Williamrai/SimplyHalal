// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/business.dart';
import 'business_table.dart';

class SimplyHalalDatabase {
  static final SimplyHalalDatabase instance = SimplyHalalDatabase._init();

  static Database? _database;

  SimplyHalalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('simplyhalal.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  //  final double? rating;
  // final String? phone;
  // final String id;
  // final String? alias;
  // @JsonKey(name: "is_closed")
  // final bool isClosed;
  // final List<Categories?> categories;
  // final String name;
  // final String url;
  // @JsonKey(name: "image_url")
  // final String imageUrl;
  // final Coordinates coordinates;

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute(''' 
    CREATE TABLE $tableBusiness;
      ${BusinessFields.id} $idType,
      ${BusinessFields.rating} $textType,
      ${BusinessFields.phone} $textType,
      ${BusinessFields.alias} $textType,
      ${BusinessFields.isClosed} $boolType,
      ${BusinessFields.name} $textType,
      ${BusinessFields.websiteUrl} $textType,
      ${BusinessFields.imageUrl} $textType,
      ${BusinessFields.latitude} $textType,
      ${BusinessFields.longitude} $textType,
      
    ''');
  }

  Future<Business> create(Business business) async {
    final db = await instance.database;

    final json = business.toJson();
    final columns =
        '${BusinessFields.rating}, ${BusinessFields.phone}, ${BusinessFields.alias}, ${BusinessFields.isClosed}, ${BusinessFields.name}, ${BusinessFields.websiteUrl}, ${BusinessFields.imageUrl}, ${BusinessFields.latitude}, ${BusinessFields.longitude} ';
    final values =
        '${json[BusinessFields.rating]}, ${json[BusinessFields.phone]}, ${json[BusinessFields.alias]}, ${json[BusinessFields.isClosed]}, ${json[BusinessFields.name]}, ${json[BusinessFields.websiteUrl]}, ${json[BusinessFields.imageUrl]}, ${json[BusinessFields.latitude]}, ${json[BusinessFields.longitude]} ';

    final id = await db
        .rawInsert('INSERT INTO $tableBusiness ($columns) VALUES ($values)');

    return business;
  }

  Future<Business> readBusiness(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBusiness,
      columns: BusinessFields.values,
      where: '${BusinessFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Business.fromJson(maps.first);
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
