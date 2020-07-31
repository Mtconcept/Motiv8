import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/qodModel.dart';

class DbHelper {
  static Database _db;
  static const String ID = 'id';
  static const String QUOTETEXT = 'text';
  static const String QUOTEAUTHOR = 'author';
  static const String TABLE = 'quotes';
  static const String DB_NAME = 'motiv8.db';

  Future<Database> get fetchQuote async {
    if (_db != null) {
      return _db;
    }
    _db = await _initializeDb();
    return _db;
  }

  _initializeDb() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _createMyTable);
  }

  _createMyTable(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY, $QUOTETEXT TEXT, $QUOTEAUTHOR TEXT)");
  }

  saveQuote(QuoteOfTheDay quoteOfTheDay) async {
    var dbClient = await fetchQuote;
    await dbClient.insert(TABLE, quoteOfTheDay.toMap());
  }

  Future<List<QuoteOfTheDay>> fetchSavedQuote() async {
    var dbClient = await fetchQuote;
    List<Map> maps =
        await dbClient.query(TABLE, columns: [ID, QUOTETEXT, QUOTEAUTHOR]);

    List<QuoteOfTheDay> quotes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        quotes.add(QuoteOfTheDay.fromJson(maps[i]));
      }
    }
    return quotes;
  }
}
