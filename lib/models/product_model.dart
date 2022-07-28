// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String codeScan;
  final String name;
  final double price;
  final int amount;
  final String uidRecord;
  final Timestamp dateRecord;
  final String status;
  ProductModel({
    required this.codeScan,
    required this.name,
    required this.price,
    required this.amount,
    required this.uidRecord,
    required this.dateRecord,
    required this.status,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codeScan': codeScan,
      'name': name,
      'price': price,
      'amount': amount,
      'uidRecord': uidRecord,
      'dateRecord': dateRecord,
      'status': status,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      codeScan: map['codeScan'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      amount: map['amount'] as int,
      uidRecord: map['uidRecord'] as String,
      dateRecord:(map['dateRecord'] ),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
