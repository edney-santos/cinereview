import 'package:cinereview/app/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;

  const CustomOutlinedButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) {
            return const BorderSide(
              color: ProjectColors.orange,
              width: 1.5,
            );
          },
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 56,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: ProjectColors.orange,
          ),
        ),
      ),
    );
  }
}
