import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StockModel {
  final String cut;
  final Timestamp cutprouct;
  StockModel({
    required this.cut,
    required this.cutprouct,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cut': cut,
      'cutdateorder': cutprouct,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      cut: map['cut'] as String,
      cutprouct: (map['cutdateorder'] ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) => StockModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
