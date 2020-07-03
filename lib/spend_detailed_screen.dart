import 'package:flutter/material.dart';

class SpendDetailedScreen extends StatelessWidget {
  static const routeName = '/spend-detailed-screen';
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
