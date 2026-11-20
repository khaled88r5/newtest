import 'package:flutter/material.dart';
class Customtextfiel extends StatelessWidget {
  const Customtextfiel({required this.hintText,required this.fillColor,this.icon, super.key, this.controller});

  final String hintText;
  final Color fillColor;
  final Icon? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintTextDirection: TextDirection.rtl,
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
        ),
        prefixIcon: icon,
    ));
  }
}