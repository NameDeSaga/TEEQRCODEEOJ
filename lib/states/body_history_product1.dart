



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/history_product.dart';
import 'package:teeqrcodeoj/states/history_product1.dart';

class BodyHistoryProduct1 extends StatefulWidget {
  BodyHistoryProduct1({Key? key}) : super(key: key);

  @override
  State<BodyHistoryProduct1> createState() => _BodyHistoryProduct1State();
}

class _BodyHistoryProduct1State extends State<BodyHistoryProduct1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ประวัติสินค้าออก'),
            
          ],
        ),
      ),
      body: HitoryProduct1(),
    );
  }
}
