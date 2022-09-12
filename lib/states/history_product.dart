import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class Historyproduct extends StatelessWidget {
  const Historyproduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowText(
          text: 'ประวัติสินค้า',
          textStyle: MyConstant().h2Style(),
        ),
        backgroundColor: MyConstant.white,
        foregroundColor: MyConstant.dark,
        elevation: 0,
      ),
    );
  }
}
