import 'package:flutter/material.dart';
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassed;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPassed = false,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
         enabledBorder: inputBorder,
    filled: true,
    contentPadding: EdgeInsetsGeometry.all(8)
    ),
    obscureText: isPassed ,
    keyboardType: textInputType,
    );
  }
}
