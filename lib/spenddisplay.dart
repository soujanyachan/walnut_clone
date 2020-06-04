import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './spend.dart';

class SpendsDisplay extends StatefulWidget {
  @override
  _SpendsDisplayState createState() => _SpendsDisplayState();
}

// need a spend subdisplay that will have the widget and the list item
// map to required lists of widget and list

// list of icons and mapped colours for the side widget

class _SpendsDisplayState extends State<SpendsDisplay> {
  final List<String> entries = []; // <String>['A', 'B', 'C'];
  List<List> sideWidgetData = []; //[[Colors.pink, Icons.card_giftcard],

  displaySpends(entries) {
    initializeDateFormatting();
    final now = DateTime.now();
    var formatter = new DateFormat("dd MMMM, hh:mm", 'en');
    var formatter2 = new DateFormat(", hh:mm", 'en');
    return Row(
      children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: sideWidgetData.map((x) {
              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: x[0],
                ),
                child: Icon(x[1]),
                height: 40,
                width: 40,
              );
            }).toList()
        ),
        Container(
          height: 200.0,
          width: 300.0,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Entry ${entries[index]}'),
                          Text('Entry ${entries[index].amount.toString()}'),
//                          Text('₹ 1692')
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${DateTime(now.year, now.month, now.day) ==
                                DateTime((entries[index].time).year,
                                    (entries[index].time).month,
                                    (entries[index].time).day)
                                || (DateTime(
                                    now.year, now.month, now.day - 1) ==
                                    DateTime((entries[index].time).year,
                                        (entries[index].time).month,
                                        (entries[index].time).day)) ?
                            (DateTime(now.year, now.month, now.day) == DateTime(
                                (entries[index].time).year,
                                (entries[index].time).month,
                                (entries[index].time).day) ? 'Today${formatter2
                                .format(entries[index].time)}'
                                : 'Yesterday${formatter2.format(
                                entries[index].time)}') :
                            formatter.format(entries[index].time)}',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey),
                          ),
                          Icon(Icons.account_balance_wallet,
                              size: 12)
                        ],
                      ),
                    ],
                  ));
            },
            separatorBuilder:
                (BuildContext context, int index) =>
            const Divider(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        entries.length > 0 ?
            displaySpends(entries) :
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text('No transactions added!'),
              ],
            )),
      ],
    );
  }
}
