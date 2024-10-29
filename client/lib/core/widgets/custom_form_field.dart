import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key, 
    required this.hintText, 
    required this.controller, 
    this.isObsecure = false,
    this.isReadOnly = false, 
    this.onTap,
  });

  final bool isReadOnly;
  final String hintText;
  final TextEditingController? controller;
  final bool isObsecure;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: isReadOnly,
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