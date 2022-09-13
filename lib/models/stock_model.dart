import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StockModel {
  final Timestamp dateOrder;
  final List<Map<String, dynamic>> mapOrderCut;
  final String status;

  StockModel({
    required this.dateOrder,
    required this.mapOrderCut,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateOrder': dateOrder,
      'mapOrder': mapOrderCut,
      'status': status,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      dateOrder: (map['dateOrder']),
      mapOrderCut: List<Map<String, dynamic>>.from(
        (map['mapOrder']),
      ),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
