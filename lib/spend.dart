import 'package:flutter/cupertino.dart';

class Spend {
String bankAccount;
String reason;
double amount;
DateTime time;
String category;
num isExpense;
String note;
Color iconColor;
List<String> tags;
String photo;
IconData iconType;
String id;

Spend({
  @required this.amount,
  this.bankAccount,
  this.reason,
  this.time,
  this.category,
  this.isExpense,
  this.iconType,
  this.iconColor,
  this.note,
  this.tags,
  this.photo,
  this.id
}) {
  if(this.time == null) {
    this.time = DateTime.now();
  }
}

Map<String, dynamic> toMap() {
  var map = new Map<String, dynamic>();
  map['amount'] =  amount.toString();
  map['bankAccount'] = bankAccount;
  map['reason'] = reason;
  map['time'] = time.toString();
  map['category'] = category.toString();
  map['isExpense'] = (isExpense == true ? 1 : 0);
  map['iconType'] = iconType.toString();
  map['note'] = note;
  map['tags'] = tags.toString();
  map['photo'] = photo;
  map['iconColor'] = iconColor.toString();
  map['id'] = id.toString();
  print(map);
  return map;
}

}