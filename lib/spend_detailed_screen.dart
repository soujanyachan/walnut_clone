import 'package:flutter/material.dart';

class SpendDetailedScreen extends StatelessWidget {
  static const routeName = '/spend-detailed-screen';

//  addSpendDialog() {
//    var inputSpendDataList = <Widget>[
//      ListTile(
//        dense: true,
//        leading: Icon(Icons.wb_sunny),
//        title: DropdownButtonHideUnderline(
//          child: DropdownButton(
//            isExpanded: true,
//            value: dropDownValue,
//            items: ["hi", "hello", "i'm here"] // accountsList / cash
//                .map<DropdownMenuItem<String>>((String value) {
//              return DropdownMenuItem<String>(
//                  value: value,
//                  child: Row(
//                    children: [Text(value)],
//                  ));
//            }).toList(),
//              onChanged: null,
//          ),
//        ),
//      ),
//      ListTile(
//        leading: Icon(Icons.brightness_3),
//        title: TextFormField(
//          decoration: InputDecoration(
//              border: InputBorder.none, hintText: 'What was this spend for?'),
//          onSaved: null,
//        ),
//      ),
//      ListTile(
//        leading: Icon(Icons.star),
//        title: TextFormField(
//          keyboardType: TextInputType.number,
//          decoration: InputDecoration(
//              border: InputBorder.none, hintText: 'Enter amount'),
//          validator: (value) {
//            if (value.isEmpty) {
//              return 'Please enter amount';
//            }
//            return null;
//          },
//          onSaved: (value) {
//            _spendAmount = value;
//          },
//        ),
//      ),
//      ListTile(
//        leading: Icon(Icons.android),
//        title: TextField(
//          readOnly: true,
//          onTap: () => _selectDate(context),
//          decoration: InputDecoration(
//            border: InputBorder.none,
//            hintText: newFormat.format(DateTime(
//                selectedDate.year,
//                selectedDate.month,
//                selectedDate.day,
//                selectedTime.hour,
//                selectedTime.minute)),
//          ),
//        ),
//      ),
//      ListTile(
//        leading: Icon(Icons.access_time),
//        title: SizedBox(
//          child: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                Text('Category'),
//                ...displayCategories(categoryList),
//              ],
//            ),
//          ),
//        ),
//      ),
//      ListTile(
//        leading: Icon(Icons.add_shopping_cart),
//        title: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text('Expense'),
//                Text(
//                  'Will be counted in total expenses',
//                  style: TextStyle(fontSize: 12),
//                )
//              ],
//            ),
//            Switch(
//              value: isExpense,
//              onChanged: (value) {
//                setState(() {
//                  isExpense = value;
//                });
//              },
//            )
//          ],
//        ),
//      ),
//      ListTile(
//          leading: Icon(Icons.edit),
//          title: TextFormField(
//            decoration: InputDecoration(
//                border: InputBorder.none, hintText: "Add a note"),
//            onSaved: (value) {
//              _spendNote = value;
//            },
//          )),
//      ListTile(
//        leading: Icon(Icons.edit),
//        title: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('Tag'),
//            ...displayTags(tagList, shouldDisplayTagList),
//          ],
//        ),
//        onTap: () {
//          setState(() {
//            shouldDisplayTagList = true;
//          });
//        },
//      ),
//      ListTile(
//          leading: Icon(Icons.edit),
//          title: GestureDetector(
//              onTap: () {
//                print("trying to get image");
//              },
//              child: Text('add a photo')))
//    ];
//    return ListView.separated(
//      itemBuilder: (context, index) {
//        var listTileHeight = 50.0;
//        if (index == 4) listTileHeight = 200.0;
//        if (index == 7) listTileHeight = 70.0;
//        return Container(
//            height: listTileHeight, child: inputSpendDataList[index]);
//      },
//      separatorBuilder: (context, index) {
//        return Divider();
//      },
//      itemCount: inputSpendDataList.length,
//    );
//  }


  @override
  Widget build(BuildContext context) {
    var spend = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("View a Spend"),
      ),

      body: Container(
        child: Text('this is the details spend screen' + spend.toString()),
      ),
    );
  }
}
