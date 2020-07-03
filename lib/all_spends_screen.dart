import 'package:flutter/material.dart';

class AllSpendsScreen extends StatelessWidget {
  static const routeName = '/all-spends';
  @override
  Widget build(BuildContext context) {
    var allSpendsList = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("View all Spends"),
      ),
      body: Container(
        child: Text('this is the all spends screen' + allSpendsList.toString()),
      ),
    );
  }
}
