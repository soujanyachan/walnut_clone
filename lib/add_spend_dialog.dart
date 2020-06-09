import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './db_helper.dart';
import 'package:quiver/iterables.dart';
import './spend.dart';

class SecondRoute extends StatefulWidget {
  final List<Spend> spendList;

  SecondRoute({@required this.spendList});
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  final _formKey = GlobalKey<FormState>();
  var dropDownValue = "hi";
  var _spendReason, _spendAmount, _spendNote;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var newFormat = DateFormat("MMM dd, HH:mm a");
  var formatTime = DateFormat("HH:mm a");
  var isExpense = false;
  var shouldDisplayTagList = false;
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
  var selectedCategory = "";
  var selectedTags = <String>[];
  var tagList = [
    "family",
    "online",
    "learning",
    "food",
    "clothes",
    "office",
    "friends"
  ];

  Future addRecord(spend) async {
    var db = new DatabaseHelper();
    await db.saveSpend(spend);
  }

  void deleteTable() async {
    var db = new DatabaseHelper();
    db.dropSpendTable();
  }

  Future getSpend() async {
    var db = new DatabaseHelper();
    await db.getSpend();
  }

  Future<Null> _selectTime(BuildContext context) async {
    final picked =
    await showTimePicker(context: context, initialTime: selectedTime);
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
    for (var i = 0; i < quads.length; i++) {
      rowList = [];
      for (var j = 0; j < 4; j++) {
        rowList.add(
          SizedBox(
            height: 75,
            width: 75,
            child: Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = quads[i][j].key;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedCategory == (quads[i][j].key)
                            ? colorList[selectedCategory]
                            : Colors.white,
                      ),
                      child: Icon(quads[i][j].value),
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Text(
                    quads[i][j].key,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      }
      fullRowList.add(Row(
        children: rowList,
      ));
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
          var tagPressed = selectedTags.contains(triplets[i][j]);
          rowList.add(
            Container(
              height: 20,
              color: tagPressed ? Colors.grey : Colors.white,
              child: FlatButton(
                child: Text('#${triplets[i][j]}'),
                onPressed: () {
                  setState(() {
                    if (tagPressed) {
                      selectedTags.remove(triplets[i][j]);
                    } else {
                      selectedTags.add(triplets[i][j]);
                    }
                  });
                },
              ),
            ),
          );
        }
        fullRowList.add(Row(
          children: rowList,
        ));
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
                    children: [Text(value)],
                  ));
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
        title: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'What was this spend for?'),
          onSaved: (value) {
            _spendReason = value;
          },
        ),
      ),
      ListTile(
        leading: Icon(Icons.star),
        title: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter amount'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter amount';
            }
            return null;
          },
          onSaved: (value) {
            _spendAmount = value;
          },
        ),
      ),
      ListTile(
        leading: Icon(Icons.android),
        title: TextField(
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: newFormat.format(DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute)),
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
                Text(
                  'Will be counted in total expenses',
                  style: TextStyle(fontSize: 12),
                )
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
          title: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Add a note"),
            onSaved: (value) {
              _spendNote = value;
            },
          )),
      ListTile(
        leading: Icon(Icons.edit),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
          title: GestureDetector(
              onTap: () {
                print("trying to get image");
              },
              child: Text('add a photo')))
    ];
    return ListView.separated(
      itemBuilder: (context, index) {
        var listTileHeight = 50.0;
        if (index == 4) listTileHeight = 200.0;
        if (index == 7) listTileHeight = 70.0;
        return Container(
            height: listTileHeight, child: inputSpendDataList[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: inputSpendDataList.length,
    );
  }

  displaySaveButtons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
            }
          },
          child: Text(
            'Save and add another'.toUpperCase(),
            style: TextStyle(color: Colors.blue),
          ),
        ),
        FlatButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
              _formKey.currentState.save();
              print(selectedCategory +
                  selectedTime.toString() +
                  selectedDate.toString());
              print(_formKey.currentState.toString());
              print(isExpense);
              print(dropDownValue);
              print(_spendReason + _spendAmount + _spendNote);
              var spend = new Spend(
                bankAccount: dropDownValue,
                reason: _spendReason,
                amount: double.parse(_spendAmount),
                isExpense: isExpense,
                category: selectedCategory,
                tags: selectedTags,
                note: _spendNote,
                iconType: categoryList[selectedCategory],
                iconColor: colorList[selectedCategory],
              );
              widget.spendList.insert(0, spend);
              await addRecord(spend);
              var resp = await getSpend();
              print(resp);
              Navigator.pop(context);
            }
          },
          child: Text(
            'Save'.toUpperCase(),
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Spend"),
      ),
      body: Form(key: _formKey, child: addSpendDialog()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        child: Builder(
          builder: (context) => displaySaveButtons(context),
        ),
      ),
    );
  }
}