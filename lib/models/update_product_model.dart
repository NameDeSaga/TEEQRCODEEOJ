import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateProductModel {
  final String codeScan;
  final String name;
  final double price;
  final int amount;

  final Timestamp dateupdate;
  final String status;
  UpdateProductModel({
    required this.codeScan,
    required this.name,
    required this.price,
    required this.amount,
    required this.dateupdate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeScan': codeScan,
      'name': name,
      'price': price,
      'amount': amount,
      'dateupdate': dateupdate,
      'status': status,
    };
  }

  factory UpdateProductModel.fromMap(Map<String, dynamic> map) {
    return UpdateProductModel(
      codeScan: map['codeScan'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      amount: map['amount'] as int,
      dateupdate: (map['dateupdate']),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProductModel.fromJson(String source) =>
      UpdateProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
