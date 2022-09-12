import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/add_product.dart';
import 'package:teeqrcodeoj/states/history_item.dart';
import 'package:teeqrcodeoj/states/history_product.dart';
import 'package:teeqrcodeoj/states/list_product.dart';
import 'package:teeqrcodeoj/states/scan_product.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class BodyOrder extends StatefulWidget {
  BodyOrder({Key? key}) : super(key: key);

  @override
  State<BodyOrder> createState() => _BodyOrdertState();
}

class _BodyOrdertState extends State<BodyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ประวัติการทำรายการ'),
            
          ],
        ),
      ),
      body: Historyitem(),
    );
  }
}
