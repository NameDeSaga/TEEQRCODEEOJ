// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Timestamp dateOrder;
  final List<Map<String, dynamic>> mapOrders;
  final String status;
  final String totalOrder;
  final String PaymentOrder;
  final String changeOrder;
  final String UidRecode;
  final String uidShopper;
  final String urlSlip;
  OrderModel({
    required this.dateOrder,
    required this.mapOrders,
    required this.status,
    required this.totalOrder,
    required this.PaymentOrder,
    required this.changeOrder,
    required this.UidRecode,
    required this.uidShopper,
    required this.urlSlip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateOrder': dateOrder,
      'mapOrders': mapOrders,
      'status': status,
      'totalOrder': totalOrder,
      'PaymentOrder': PaymentOrder,
      'changeOrder': changeOrder,
      'UidRecode': UidRecode,
      'uidShopper': uidShopper,
      'urlSlip': urlSlip,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      dateOrder: (map['dateOrder']),
      mapOrders: List<Map<String, dynamic>>.from(map['mapOrders']),
      status: map['status'] as String,
      totalOrder: map['totalOrder'] as String,
      PaymentOrder: map['PaymentOrder'] as String,
      changeOrder: map['changeOrder'] as String,
      UidRecode: map['UidRecode'] as String,
      uidShopper: map['uidShopper'] as String,
      urlSlip: map['urlSlip'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
