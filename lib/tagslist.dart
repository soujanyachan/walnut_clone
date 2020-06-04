import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TagsList extends StatefulWidget {
  @override
  _TagsListState createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {
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
                child: Text('Tags'),
              ),
              Container(
                width: 500,
                height: 90,
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration:
                                BoxDecoration(color: Colors.indigo),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Icon(Icons.ac_unit),
                                      height: 40,
                                      width: 40,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text('Balance'),
                                                    Text(
                                                      'Updated on some date',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey),
                                                    )
                                                  ],
                                                ),
                                                Text('Spends: 2'),
                                              ],
                                            ))
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
            ],
          ),
        ),
      ),
    );
  }
}
