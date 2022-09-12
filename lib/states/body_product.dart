import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/add_product.dart';
import 'package:teeqrcodeoj/states/list_product.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class BodyProduct extends StatefulWidget {
  BodyProduct({Key? key}) : super(key: key);

  @override
  State<BodyProduct> createState() => _BodyProductState();
}

class _BodyProductState extends State<BodyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('สินค้าทั้งหมด'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ),
                )
              },
              child: Text('เพิ่มสินค้า', style: TextStyle(fontSize: 10.0)),
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            )
          ],
        ),
      ),
      body: ListProduct(),
    );
  }
}
