import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './spend.dart';
import 'dart:convert';

var categoryList = {
  "Bills": Icons.format_list_bulleted,
  "EMI": Icons.graphic_eq,
  "Entertainment": Icons.stars,
  "Food & Drink": Icons.fastfood,
  "Fuel": Icons.local_gas_station,
  "Groceries": Icons.shopping_basket,
  "Health": Icons.healing,
  "Investment": Icons.attach_money,
  "Shopping": Icons.shopping_cart,
  "Transfer": Icons.transform,
  "Travel": Icons.card_travel,
  "Other": Icons.devices_other
};

var colorList = {
  "Bills": Colors.yellow,
  "EMI": Colors.brown,
  "Entertainment": Colors.red,
  "Food & Drink": Colors.cyanAccent,
  "Fuel": Colors.indigo,
  "Groceries": Colors.green,
  "Health": Colors.red,
  "Investment": Colors.pink,
  "Shopping": Colors.amber,
  "Transfer": Colors.purple,
  "Travel": Colors.deepOrange,
  "Other": Colors.teal
};

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
    int res = await dbClient.insert("Spend", spend.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("res.toString()");
    print(res.toString());
    return res;
  }

  void dropSpendTable() async {
    var dbClient = await db;
    await dbClient.execute("DROP TABLE [IF EXISTS] Spend");
  }

  Future<List<Spend>> getSpend() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Spend');
    List<Spend> spends = new List();
    for (int i = 0; i < list.length; i++) {
      var spend = new Spend(
          amount: list[i]["amount"],
          bankAccount: list[i]["bankAccount"],
          reason: list[i]["reason"],
          time: DateTime.parse(list[i]["time"]),
          category: list[i]["category"],
          isExpense: list[i]["isExpense"],
          iconType: categoryList[list[i]["category"]],
          iconColor: colorList[list[i]["category"]],
          note: list[i]["note"],
          tags: (jsonDecode(list[i]["tags"]) as List<dynamic>).cast<String>(),
          photo: list[i]["photo"]);
      spends.add(spend);
    }
    spends.sort((a, b) => b.time.compareTo(a.time));
//    print("in get spend db helper");
//    print(spends.toString());
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
