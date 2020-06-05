import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';
import './appbarwidget.dart';
import './spendslist.dart';
import './reminderslist.dart';
import './accountslist.dart';
import './tagslist.dart';
import './add_entry_dialog.dart';
import 'package:quiver/iterables.dart';

// TODO: add spends
// TODO: read and write csv output
// TODO: charts
// TODO: read smses and update bank accounts
// TODO: category basic list with icons
// TODO:


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  var dropDownValue = "hi";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var newFormat = DateFormat("MMM dd, HH:mm a");
  var formatTime = DateFormat("HH:mm a");
  var isExpense = false;
  var shouldDisplayTagList = false;
  var categoryList = {
    "Bills":Icons.format_list_bulleted,
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

  var tagList = ["family", "online", "learning", "food", "clothes", "office", "friends"];

  Future<Null> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
      initialTime: selectedTime
    );
    setState(() {
      selectedTime = picked;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      await _selectTime(context);
      setState(() {
        selectedDate = picked;
      });
    }
  }

  displayCategories(categoryList) {
    var quads = partition(categoryList.entries, 4).toList();
    var rowList = <Widget>[];
    var fullRowList = <Widget>[];
    for (var i=0; i<quads.length; i++) {
      rowList = [];
      for(var j=0;j<4; j++) {
        rowList.add(
            SizedBox(
              height: 75,
              width: 75,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft:
                          Radius.circular(7.0),
                          bottomLeft:
                          Radius.circular(7.0)),
                      ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: Icon(quads[i][j].value),
                        height: 40,
                        width: 40,
                      ),
                      Text(quads[i][j].key, overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
            ),
        );
      }
      fullRowList.add(
        Row(
          children: rowList,
        )
      );
    }
    return fullRowList;
  }

  displayTags(tagList, shouldDisplayTagList) {
    if (!shouldDisplayTagList) {
      return [Container()];
    }
    var triplets = partition(tagList, 3).toList();
    var rowList = <Widget>[];
    var fullRowList = <Widget>[];
    try {
      for (var i = 0; i < triplets.length; i++) {
        rowList = [];
        for (var j = 0; j < 3; j++) {
          rowList.add(
            Container(
              height: 20,
              child: FlatButton(
                child: Text('#${triplets[i][j]}'),
                onPressed: () {},
              ),
            ),
          );
        }
        fullRowList.add(
            Row(
              children: rowList,
            )
        );
      }
    } catch (e) {
      return fullRowList;
    }
    return fullRowList;
  }

  addSpendDialog() {
    var inputSpendDataList = <Widget>[
      ListTile(
        dense: true,
        leading: Icon(Icons.wb_sunny),
        title: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            value: dropDownValue,
            items: ["hi", "hello", "i'm here"] // accountsList / cash
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(value)
                    ],
                  )
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropDownValue = value;
              });
            },
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.brightness_3),
        title: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What was this spend for?'
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.star),
        title: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter amount'
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.android),
        title: TextField(
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: newFormat.format(DateTime(selectedDate.year, selectedDate.month,
                selectedDate.day, selectedTime.hour, selectedTime.minute)),
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.access_time),
        title: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Category'),
                ...displayCategories(categoryList),
              ],
            ),
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.add_shopping_cart),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Expense'),
                Text('Will be counted in total expenses', style: TextStyle(fontSize: 12),)
              ],
            ),
            Switch(
              value: isExpense,
              onChanged: (value) {
                setState(() {
                  isExpense = value;
                });
              },
            )
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.edit),
        title: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
            hintText: "Add a note"
          ),
        )
      ),
      ListTile(
          leading: Icon(Icons.edit),
          title: Column(
            children: <Widget>[
              Text('Tag'),
              ...displayTags(tagList, shouldDisplayTagList),
            ],
          ),
        onTap: () {
          setState(() {
            shouldDisplayTagList = true;
          });
        },
      ),
      ListTile(
          leading: Icon(Icons.edit),
          title: Text('add a photo')
      )
    ];
    return ListView.separated(
        itemBuilder: (context, index) {
          var listTileHeight = 50.0;
          if (index == 4) listTileHeight = 200.0;
          if (index == 7) listTileHeight = 70.0;
          return Container(
            height: listTileHeight,
            child: inputSpendDataList[index]
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: inputSpendDataList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Spend"),
      ),
      body: addSpendDialog(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save and add another'.toUpperCase(), style: TextStyle(color: Colors.blue),),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save'.toUpperCase(), style: TextStyle(color: Colors.blue),),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
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
            SpendsList(),
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
            MaterialPageRoute(builder: (context) => SecondRoute()),
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
  var spendsList = [];
  var remindersList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstRoute(),
    );
  }
}
