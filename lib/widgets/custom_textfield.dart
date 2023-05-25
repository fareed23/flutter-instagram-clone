import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  final Widget? icon;

  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.isPass = false,
    this.icon,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    );
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        suffixIcon: icon,
      ),
      obscureText: isPass,
      keyboardType: textInputType,
    );
  }
}
