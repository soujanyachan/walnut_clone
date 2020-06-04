import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class AccountsList extends StatefulWidget {
  @override
  _AccountsListState createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: 500,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Accounts'),
              ),
              Container(
                width: 500,
                height: 110,
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft:
                                        Radius.circular(15.0),
                                        bottomLeft:
                                        Radius.circular(15.0)),
                                    color: Colors.grey[200]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: Icon(Icons.shuffle),
                                      height: 40,
                                      width: 40,
                                    ),
                                    Text('Freecharge')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 8.0),
                                          child: Text('number spent'),
                                        ),
                                        Divider(color: Colors.black),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text('Balance'),
                                              Text(
                                                'Updated on some date',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                    Colors.grey),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                  itemCount: 3,
                  pagination: new SwiperPagination(),
                  control: new SwiperControl(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('See all'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
