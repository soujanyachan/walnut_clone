import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import './appbarwidget.dart';
import './spendslist.dart';
import './reminderslist.dart';
import './accountslist.dart';
import './tagslist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var spendsList = [];
  var remindersList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBarWidget(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SpendsList(),
              RemindersList(),
              AccountsList(),
              TagsList()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
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
      ),
    );
  }
}
