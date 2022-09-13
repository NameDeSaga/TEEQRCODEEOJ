// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  final double? width;
  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      margin: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
          onPressed: pressFunc,
          child: ShowText(
            text: label,
            textStyle: MyConstant().h2Style(),
          )),
    );
  }
}
