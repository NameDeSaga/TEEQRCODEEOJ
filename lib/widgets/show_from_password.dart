// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowFormPassword extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final Function(String) changeFunc;
  final TextEditingController? textEditingController;
  const ShowFormPassword({
    Key? key,
    required this.iconData,
    required this.hint,
    required this.changeFunc,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: 250,
      child: TextFormField(
        obscureText: true,
        controller: textEditingController,
        onChanged: changeFunc,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(),


        ),
      ),
    );
  }
}