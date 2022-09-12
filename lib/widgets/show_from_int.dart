// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowFormInt extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final Function(String) changeFunc;
  final TextEditingController? textEditingController;
  const ShowFormInt({
    Key? key,
    required this.iconData,
    required this.hint,
    required this.changeFunc,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 140),
        width: 200,
        child: TextFormField(
            controller: textEditingController,
            onChanged: changeFunc,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(iconData),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start));
  }
}
