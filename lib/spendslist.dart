import 'package:flutter/material.dart';
import 'package:walnut_clone/all_spends_screen.dart';
import 'package:walnut_clone/main.dart';
import './spenddisplay.dart';
import './spend.dart';

class SpendsList extends StatefulWidget {
  final List<Spend> spendList;

  SpendsList({@required this.spendList});

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
                padding: const EdgeInsets.all(8.0),
                child: Text('Spends'),
              ),
              SpendsDisplay(spendList: widget.spendList.length > 3 ? widget.spendList.sublist(0,3) : widget.spendList,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print("more spends pressed");
                        Navigator.of(context).pushNamed(AllSpendsScreen.routeName, arguments: widget.spendList);
                      },
                      child: Text('More Spends',
                          style: TextStyle(color: Colors.blueAccent)),
                    ),
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
