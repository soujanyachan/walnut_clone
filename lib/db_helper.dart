import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './spend.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Spend(id INTEGER PRIMARY KEY, amount REAL, bankAccount TEXT, reason TEXT, time TEXT, category TEXT, isExpense INTEGER, iconType TEXT, note TEXT, photo TEXT, tags TEXT, iconColor TEXT)");
  }

  Future<int> saveSpend(Spend spend) async {
    var dbClient = await db;
    int res = await dbClient.insert("Spend", spend.toMap());
    return res;
  }

  void dropSpendTable() async {
    var dbClient = await db;
    await dbClient.execute(
        "DROP TABLE [IF EXISTS] Spend");
  }

  Future<List<Spend>> getSpend() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Spend');
    List<Spend> spends = new List();
    for (int i = 0; i < list.length; i++) {
      var spend = new Spend(amount: list[i]["amount"]);
      print(list[i]["id"]);
      print(list[i]["amount"]);
      spends.add(spend);
    }
    print(spends.toString());
    return spends;
  }

//  Future<int> deleteUsers(User user) async {
//    var dbClient = await db;
//
//    int res =
//    await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user.id]);
//    return res;
//  }
//
//  Future<bool> update(User user) async {
//    var dbClient = await db;
//    int res =   await dbClient.update("User", user.toMap(),
//        where: "id = ?", whereArgs: <int>[user.id]);
//    return res > 0 ? true : false;
//  }
}