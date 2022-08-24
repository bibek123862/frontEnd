import 'dart:io';
import 'package:clothing_roll/model/productModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Product table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'clothing_roll.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Product('
          'id INTEGER PRIMARY KEY,'
          'productName TEXT,'
          'productDesc TEXT,'
          'productDisplayPrice INTEGER,'
          'productActualPrice INTEGER,'
          'productThumbnail TEXT'
          ')');
    });
  }

  // Insert product on database
  createProduct(Product newProduct) async {
    await deleteAllProduct();
    final db = await database;
    final res = await db.insert('Product', newProduct.toJson());

    return res;
  }

  // Delete all products
  Future<int> deleteAllProduct() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Product');

    return res;
  }


  

  Future<List<Product>> getAllProduct() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Product");

    List<Product> list =
        res.isNotEmpty ? res.map((c) => Product.fromJson(c)).toList() : [];

    return list;
  }



}

