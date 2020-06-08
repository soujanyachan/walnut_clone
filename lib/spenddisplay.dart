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

class _SpendsDisplayState extends State<SpendsDisplay> {
  List<List> sideWidgetData = [[Colors.pink, Icons.card_giftcard]];

  displaySpends() {
    final List<Spend> entries = widget.spendList; // <String>['A', 'B', 'C'];
    initializeDateFormatting();
    final now = DateTime.now();
    var formatter = new DateFormat("dd MMMM, hh:mm", 'en');
    var formatter2 = new DateFormat(", hh:mm", 'en');
    if (entries.length > 0) {
      return Row(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: entries.map((x) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink,
                  ),
                  child: Icon(x.iconType),
                  height: 40,
                  width: 40,
                );
              }).toList()
          ),
          Container(
            height: entries.length * 50.0,
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
                            Text('${entries[index].reason}'),
                            Text('${entries[index].amount.toString()}'),
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
                              (DateTime(now.year, now.month, now.day) ==
                                  DateTime(
                                      (entries[index].time).year,
                                      (entries[index].time).month,
                                      (entries[index].time).day)
                                  ? 'Today${formatter2
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
                    )
                );
              },
              separatorBuilder:
                  (BuildContext context, int index) =>
              const Divider(),
            ),
          )
        ],
      );
    } else
      return
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Text('No transactions added!'),
              ],
            )
        );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        displaySpends()
      ],
    );
  }
}
