import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final Color color;
  final TextInputType keyType;
  final bool obscureText;
  final dynamic validators;
  final dynamic onTap;
  final bool autoFocus;
  final void Function(String)? onChanged;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.color,
    required this.keyType,
    required this.obscureText,
    this.validators,
    this.onTap,
    this.autoFocus = false,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: ProjectText.label,
            )
          ],
        ),
        Container(height: 4),
        TextFormField(
          onChanged: onChanged,
          autofocus: autoFocus,
          onTap: onTap,
          validator: validators,
          controller: controller,
          cursorColor: color,
          keyboardType: keyType,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.01),
            labelText: placeholder,
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
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
