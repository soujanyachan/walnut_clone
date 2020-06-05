import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';
import './appbarwidget.dart';
import './spendslist.dart';
import './reminderslist.dart';
import './accountslist.dart';
import './tagslist.dart';
import './add_entry_dialog.dart';

void main() => runApp(MyApp());

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
        title: Text('Category'),
      ),
      ListTile(
        leading: Icon(Icons.add_shopping_cart),
        title: Text('Expense'),
      ),
      ListTile(
        leading: Icon(Icons.data_usage),
        title: Text('Note')
      ),
      ListTile(
        leading: Icon(Icons.edit),
        title: TextField(
          decoration: InputDecoration(
            hintText: "Add a note"
          ),
        )
      ),
      ListTile(
          leading: Icon(Icons.edit),
          title: Text('Tag'),
        onTap: () {},
      ),
      ListTile(
          leading: Icon(Icons.edit),
          title: Text('add a photo')
      )
    ];
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            height: 50.0,
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
