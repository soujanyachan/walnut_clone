import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:walnut_clone/all_spends_screen.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import './spend.dart';

class AppBarWidget extends StatefulWidget {
  final List<Spend> spendsList;

  AppBarWidget(this.spendsList);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  double _currentSliderValue = 0;
  double _lowerValue = 50;
  double _upperValue = 180;

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//  showOverlay(BuildContext context) async {
//    OverlayState overlayState = Overlay.of(context);
//    OverlayEntry overlayEntry;
//    overlayEntry = OverlayEntry(
//        builder: (context) => Positioned(
//          top: MediaQuery.of(context).size.height / 3.0,
//          left: MediaQuery.of(context).size.width / 8.0,
//          width: MediaQuery.of(context).size.width * 0.75,
//          child: Card(
//            color: Colors.pink,
//            child:
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                children: <Widget>[
//                  Text('select your budget'),
//                  Row(
//                    children: <Widget>[
//                      Text('Budget value'),
//                      Container(
//                        width: 100,
//                        child: TextFormField(
//                          decoration: InputDecoration(
//                              border: InputBorder.none, hintText: 'Budget value'),
//                          onSaved: (value) {
//                            print(value);
//                          },
//                        ),
//                      ),
//                    ],
//                  ),
//                  Slider(
//                    value: _currentSliderValue.toDouble(),
//                    min: 0,
//                    max: 200000,
//                    divisions: 10,
//                    label: _currentSliderValue.round().toString(),
//                    onChanged: (double value) {
//                      setState(() {
//                        _currentSliderValue = value;
//                        overlayEntry.markNeedsBuild();
//                      });
//                    },
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      RaisedButton(
//                        onPressed: () {
//                          print('removing overlay entry 1');
//                          overlayEntry.remove();
//                        },
//                        child: Text('Save'),
//                      ),
//                      RaisedButton(
//                        onPressed: () {
//                          print('removing overlay entry 2');
//                          overlayEntry.remove();
//                        },
//                        child: Text('Close'),
//                      )
//                    ],
//                  )
//                ],
//              ),
//            ),
//          ),
//        ));
//    overlayState.insert(overlayEntry);
//  }

  getAppBarWidget(BuildContext ctx) {
    var totalAmountSpent = 0.0;
    this.widget.spendsList.forEach((spend) {
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
                              Navigator.of(ctx).pushNamed(AllSpendsScreen.routeName, arguments: this.widget.spendsList);
                            },
                          child: Row(
                            children: <Widget>[
                              Text('₹'),
                              Text(totalAmountSpent.toString(), style: TextStyle(fontSize: 40)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
//                            showOverlay(ctx);
                            showAlertDialog(ctx);
                          },
                          child: new LinearPercentIndicator(
                            width: 140.0,
                            lineHeight: 14.0,
                            percent: 0.5,
                            backgroundColor: Colors.white,
                            progressColor: Colors.lightBlueAccent,
                            trailing: Text("90.0%"),
                          ),
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
                              Navigator.of(ctx).pushNamed(AllSpendsScreen.routeName, arguments: this.widget.spendsList);
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
//  return Slider(
//    value: _currentSliderValue.toDouble(),
//    min: 0,
//    max: 100,
//    divisions: 5,
//    label: _currentSliderValue.round().toString(),
//    onChanged: (double value) {
//      print(value.runtimeType);
//      print(value);
//      print("value");
//      setState(() {
//        _currentSliderValue = value;
//      });
//    },
//  );
  }
}
