import 'package:flutter/material.dart';
import './spenddisplay.dart';

class AllSpendsScreen extends StatelessWidget {
  static const routeName = '/all-spends';
  @override
  Widget build(BuildContext context) {
    var allSpendsList = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("View all Spends"),
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Spends'),
            ),
            SpendsDisplay(spendList: allSpendsList),
          ],
        ),
      ),
    );
  }
}
