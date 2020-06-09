import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './spend.dart';

class SpendsDisplay extends StatefulWidget {
  final List<Spend> spendList;

  SpendsDisplay({@required this.spendList});

  @override
  _SpendsDisplayState createState() => _SpendsDisplayState();
}

// need a spend subdisplay that will have the widget and the list item
// map to required lists of widget and list

// list of icons and mapped colours for the side widget

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

var tableRow = TableRow(children: [
  Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.pink,
    ),
    child: Icon(
      Icons.card_giftcard,
      size: 18,
    ),
    height: 30,
    width: 30,
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('hello spend'),
          Text('₹ 1234'),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              'time to party',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.account_balance_wallet, size: 12),
          )
        ],
      ),
    ],
  ),
]);

class _SpendsDisplayState extends State<SpendsDisplay> {
  Spend currentCategoryDisplay;

  List<TableRow> spendListToTable() {
    initializeDateFormatting();
    var f = new NumberFormat("###");
    final now = DateTime.now();
    var formatter = new DateFormat("dd MMMM, hh:mm", 'en');
    var formatter2 = new DateFormat(", hh:mm", 'en');
    return widget.spendList.map((x) {
      return TableRow(children: [
        GestureDetector(
          onTap: () {
            print("category circle has been tapped for " + x.reason);
            setState(() {
              if (currentCategoryDisplay == null) {
                currentCategoryDisplay = x;
              } else
                currentCategoryDisplay = null;
            });
          },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: x.iconColor,
                  ),
                  child: Icon(x.iconType),
                  height: 40,
                  width: 40,
                ),
                currentCategoryDisplay == x
                      ? Text(
                          x.category,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
              ],
            ),
        ),
        currentCategoryDisplay == x
            ? Container(
                height: 50.0,
                width: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length - 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      VerticalDivider(
                    color: Colors.white,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var listCat = categoryList.keys.toList();
                    listCat.remove(currentCategoryDisplay.category);
                    var category = listCat[index];
                    return GestureDetector(
                      onTap: () {
                        print("switch " + category);
                      },
                      child:
                      SizedBox(
                        height: 20,
                        width: 40,
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorList[category],
                              ),
                              child: Icon(
                                categoryList[category],
                                size: 20.0,
                              ),
                              height: 30,
                              width: 30,
                            ),
                            Text(
                              category,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${x.reason}'),
                        Text('₹ ${f.format(x.amount)}'),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${DateTime(now.year, now.month, now.day) == DateTime((x.time).year, (x.time).month, (x.time).day) || (DateTime(now.year, now.month, now.day - 1) == DateTime((x.time).year, (x.time).month, (x.time).day)) ? (DateTime(now.year, now.month, now.day) == DateTime((x.time).year, (x.time).month, (x.time).day) ? 'Today${formatter2.format(x.time)}' : 'Yesterday${formatter2.format(x.time)}') : formatter.format(x.time)}',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      x.isExpense
                          ? Icon(Icons.account_balance_wallet, size: 12)
                          : Container()
                    ],
                  ),
                ],
              ),
      ]);
    }).toList();
  }

  var table = Table(
      columnWidths: {0: FractionColumnWidth(.15), 1: FractionColumnWidth(.85)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [tableRow, tableRow, tableRow]);

  @override
  Widget build(BuildContext context) {
    var newTable = Table(
        columnWidths: {
          0: FractionColumnWidth(.15),
          1: FractionColumnWidth(.85)
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [...spendListToTable()]);
    print(widget.spendList);
    return widget.spendList.length > 0
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: widget.spendList.length * 50.0,
                  width: 400,
                  child: newTable)
            ],
          )
        : Container(
            child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text('No transactions added!'),
              ],
          ),
            ));
  }
}
