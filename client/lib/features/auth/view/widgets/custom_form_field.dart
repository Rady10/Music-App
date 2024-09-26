import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key, required this.hintText, required this.controller, this.isObsecure = false});

  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (val){
        if(val!.trim().isEmpty){
          return '$hintText is missing';
        }
        return null;
      },
      obscureText: isObsecure,
    );
  }
}