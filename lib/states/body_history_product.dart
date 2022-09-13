



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/history_product.dart';

class BodyHistoryProduct extends StatefulWidget {
  BodyHistoryProduct({Key? key}) : super(key: key);

  @override
  State<BodyHistoryProduct> createState() => _BodyHistoryProductState();
}

class _BodyHistoryProductState extends State<BodyHistoryProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ประวัติสินค้า'),
            
          ],
        ),
      ),
      body: Historyproduct(),
    );
  }
}
