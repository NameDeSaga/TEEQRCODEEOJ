// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BillHistory {
  final int? id;
  final String codeScan;
  final String UidRecode;
  final String name;
  final double price;
  final int amount;
  final double change;
  final double total;
  final double payment;
  final Timestamp dateRecordbill;
  BillHistory({
    this.id,
    required this.codeScan,
    required this.UidRecode,
    required this.name,
    required this.price,
    required this.amount,
    required this.change,
    required this.total,
    required this.payment,
    required this.dateRecordbill,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'codeScan': codeScan,
      'UidRecode': UidRecode,
      'name': name,
      'price': price,
      'amount': amount,
      'change': change,
      'total': total,
      'payment': payment,
      'dateRecordbill': dateRecordbill,
    };
  }

  factory BillHistory.fromMap(Map<String, dynamic> map) {
    return BillHistory(
      id: map['id'] != null ? map['id'] as int : null,
      codeScan: map['codeScan'] as String,
      UidRecode: map['UidRecode'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      amount: map['amount'] as int,
      change: map['change'] as double,
      total: map['total'] as double,
      payment: map['payment'] as double,
      dateRecordbill: (map['dateRecordbill']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BillHistory.fromJson(String source) => BillHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}
