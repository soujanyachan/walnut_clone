import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';
import './appbarwidget.dart';
import './spendslist.dart';
import './reminderslist.dart';
import 'dart:convert';
import './accountslist.dart';
import './tagslist.dart';
import './add_entry_dialog.dart';
import 'package:image_picker/image_picker.dart';
import './spend.dart';
import './db_helper.dart';
import './add_spend_dialog.dart';

// TODO: display old spends from db
// TODO: read and write csv output
// TODO: read smses
//  TODO: update bank accounts
// TODO: routes: all spends page, all reminders page,
//  TODO: all accounts page, chart page, search page,
// TODO: Profile page, set monthly budget page

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  List<Spend> spendsList = [];
  var spendsListDb;
  Future<String>getAllSpends() async {
    var db = new DatabaseHelper();
    var spends = await db.getSpend();
    setState(() {
      spendsListDb = spends;
    });
    return "done";
  }

  @override
  void initState() {
    super.initState();
    getAllSpends().then((res) {
      print("got all spends from db");
      print(spendsList);
      spendsList = spendsListDb + spendsList;
      print(spendsListDb.toString() + spendsList.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getAllSpends(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: AppBarWidget(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SpendsList(
                      spendList: spendsListDb != null ? spendsListDb : (spendsList.isNotEmpty ? spendsList : []),
                    ),
                    RemindersList(),
                    AccountsList(),
                    TagsList()
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SecondRoute(spendList: spendsList)),
                  );
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BottomAppBar(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ]),
                    height: 40.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  )),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class _MyAppState extends State<MyApp> {
  var remindersList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstRoute(),
    );
  }
}
