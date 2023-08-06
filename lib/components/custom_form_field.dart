import 'package:cinereview/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Color color;
  final TextInputType keyType;
  final bool obscureText;
  final dynamic validators;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.color,
    required this.keyType,
    required this.obscureText,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validators,
      controller: controller,
      cursorColor: color,
      keyboardType: keyType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.01),
        labelText: labelText,
        labelStyle: const TextStyle(color: ProjectColors.lightGray),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: color,
            width: 1.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      ),
    );
  }
}
