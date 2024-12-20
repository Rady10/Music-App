import 'package:flutter/material.dart';
import 'package:music/core/theme/app_pallete.dart';

class GradinetButton extends StatelessWidget {
  const GradinetButton({super.key, required this.buttonText, required this.onTap});

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.5),
            Colors.greenAccent.withOpacity(0.7),
          ]
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor
        ),
        onPressed: onTap,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}