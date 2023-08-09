import 'package:cinereview/app/styles/colors.dart';
import 'package:flutter/material.dart';

final buttonStyle = ElevatedButton.styleFrom(
  textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  elevation: 0,
  backgroundColor: Colors.transparent,
  padding: const EdgeInsets.all(16),
);

class BlockButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  const BlockButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [ProjectColors.orange, ProjectColors.pink],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: onPressed,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
