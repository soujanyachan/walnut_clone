import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:walnut_clone/all_spends_screen.dart';
import './spend.dart';

class AppBarWidget extends StatelessWidget {
  final List<Spend> spendsList;

  AppBarWidget(this.spendsList);

  getAppBarWidget(BuildContext ctx) {
    var totalAmountSpent = 0.0;
    this.spendsList.forEach((spend) {
      totalAmountSpent += spend.amount;
    });
    initializeDateFormatting();
    DateTime now = new DateTime.now();
    var formatter = new DateFormat("MMMM", 'en');
    return Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(74, 143, 226, 1),
                  Color.fromRGBO(74, 97, 226, 1)
                ])),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(formatter.format(now)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Icon(Icons.people),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Icon(Icons.search),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                              print("more spends pressed");
                              Navigator.of(ctx).pushNamed(AllSpendsScreen.routeName, arguments: this.spendsList);
                            },
                          child: Row(
                            children: <Widget>[
                              Text('₹'),
                              Text(totalAmountSpent.toString(), style: TextStyle(fontSize: 40)),
                            ],
                          ),
                        ),
                        new LinearPercentIndicator(
                          width: 140.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.white,
                          progressColor: Colors.lightBlueAccent,
                          trailing: Text("90.0%"),
                        ),
                        Text('Safe to spend some amount'),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Icon(Icons.insert_chart),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: IconButton(
                            icon: Icon(Icons.pie_chart),
                            tooltip: 'Increase volume by 10',
                            onPressed: () {
                              Navigator.of(ctx).pushNamed(AllSpendsScreen.routeName, arguments: this.spendsList);
                            },
                          )
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return getAppBarWidget(context);
  }
}
