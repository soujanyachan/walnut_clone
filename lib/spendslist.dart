import 'package:flutter/material.dart';
import './spenddisplay.dart';

class SpendsList extends StatefulWidget {
  @override
  _SpendsListState createState() => _SpendsListState();
}

class _SpendsListState extends State<SpendsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Spends'),
              ),
              SpendsDisplay(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('More Spends',
                        style: TextStyle(color: Colors.blueAccent)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
