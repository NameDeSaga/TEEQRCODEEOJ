import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StockModel {
  final Timestamp dateOrder;
  final String mapOrderscut;
  final String status;

  StockModel({
    
    required this.dateOrder,
    required this.mapOrderscut,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateOrder': dateOrder,
      'mapOrders': mapOrderscut,
      'status': status,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      dateOrder: (map['dateOrder']),
      mapOrderscut: map['mapOrders'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
