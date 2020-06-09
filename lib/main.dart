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

List<Spend> spendsList = [];

// TODO: read and write csv output
// TODO: charts
// TODO: read smses and update bank accounts

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SpendsList(spendList: spendsList,),
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
            MaterialPageRoute(builder: (context) => SecondRoute(spendList: spendsList)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
            height: 40.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          )),
    );
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
