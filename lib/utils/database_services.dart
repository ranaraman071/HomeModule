import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperr {
  static const String _databaseName = 'database.db';
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    // Get the application directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String dbPath = join(appDocDir.path, _databaseName);

    // Check if the database already exists
    final File dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      // Copy from assets if it doesn't exist
      ByteData data = await rootBundle.load('assets/databases/$_databaseName');
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await dbFile.writeAsBytes(bytes);
    }

    // Open the database
    _database = await openDatabase(dbPath);
    return _database!;
  }

  // Fetch data example
  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final db = await getDatabase();
    return await db.query(table);
  }

  // Save data example
  static Future<int> insertData(String table, Map<String, dynamic> values) async {
    final db = await getDatabase();
    return await db.insert(table, values);
  }
}


class DatabaseHelper {
  static const String _databaseName = 'database.db';
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    // Get the application directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String dbPath = join(appDocDir.path, _databaseName);

    // Check if the database already exists
    final File dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      // Copy from assets if it doesn't exist
      ByteData data = await rootBundle.load('assets/databases/$_databaseName');
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await dbFile.writeAsBytes(bytes);
    }

    // Open the database
    _database = await openDatabase(dbPath);
    return _database!;
  }

  // Fetch data using custom query
  static Future<List<Map<String, dynamic>>> fetchDataWithQuery(String query, [List<dynamic>? args]) async {
    final db = await getDatabase();
    return await db.rawQuery(query, args ?? []);
  }

  // Save data example
  static Future<int> insertData(String table, Map<String, dynamic> values) async {
    final db = await getDatabase();
    return await db.insert(table, values);
  }
}
