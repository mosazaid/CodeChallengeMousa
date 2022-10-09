// needed for Directory()
import 'dart:io';

// needed for SQL database operations
import 'package:codechallengemousa/data/country_currency.dart';
import 'package:sqflite/sqflite.dart';

// needed for getApplicationDocumentsDirectory()
import 'package:path_provider/path_provider.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = "currencyDB.db";

  // Increment this version when you need to change the schema.
  static const _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/$_databaseName';
    // Open the database, can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableCurrency (
            $columnId TEXT PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnCurrencyId TEXT NOT NULL,
            $columnCurrencyName TEXT NOT NULL,
            $columnCurrencySymbol TEXT,
            $columnAlpha3 TEXT NOT NULL
          )
          ''');
  }

  // Database helper methods:

  Future<int> insert(CountryCurrency currency) async {
    Database db = await database;
    int id = await db.insert(tableCurrency, currency.toMap());
    return id;
  }

  Future<CountryCurrency?> queryCurrency(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableCurrency,
        columns: [
          columnId,
          columnName,
          columnCurrencyId,
          columnCurrencyName,
          columnCurrencySymbol,
          columnAlpha3
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CountryCurrency.fromMap(maps.first);
    }
    return null;
  }

  Future<List<CountryCurrency>?> queryAllCurrency() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableCurrency);
    if (maps.isNotEmpty) {
      List<CountryCurrency> words = [];
      for (var map in maps) {
        words.add(CountryCurrency.fromMap(map));
      }
      return words;
    }
    return null;
  }

  Future<int> deleteCurrency(int id) async {
    Database db = await database;
    return await db
        .delete(tableCurrency, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(CountryCurrency currency) async {
    Database db = await database;
    return await db.update(tableCurrency, currency.toMap(),
        where: '$columnId = ?', whereArgs: [currency.id]);
  }
}
