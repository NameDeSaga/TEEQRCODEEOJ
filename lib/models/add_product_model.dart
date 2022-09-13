import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddProductModel {
  final String codeScan;
  final String name;
  final double price;
  final int amount;
  final Timestamp dateRecord;
  final String status;
  AddProductModel({
    required this.codeScan,
    required this.name,
    required this.price,
    required this.amount,
    required this.dateRecord,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeScan': codeScan,
      'name': name,
      'price': price,
      'amount': amount,
      'dateRecord': dateRecord,
      'status': status,
    };
  }

  factory AddProductModel.fromMap(Map<String, dynamic> map) {
    return AddProductModel(
      codeScan: map['codeScan'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      amount: map['amount'] as int,
      dateRecord: (map['dateRecord']),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductModel.fromJson(String source) =>
      AddProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
