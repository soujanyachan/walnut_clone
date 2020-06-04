import 'package:flutter/cupertino.dart';

class Spend {
  // bank account
// reason for expense
// amount
// time
// category
// is expense
// note
// tag
// photo of receipt/warranty
String bankAccount;
String reason;
String paidFrom;
String paidTo;
double amount;
DateTime time;
String category;
bool isExpense;
String note;
String tag;
String photo;
Widget iconType;

Spend(this.amount, this.bankAccount) {
  this.time = DateTime.now();
}

void driving() {
  print('${this.amount} ${this.bankAccount} ${this.time} is driving');
}

}