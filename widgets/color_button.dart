import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Color color;
  final String mood;
  final Function(Color) onTap;

  const ColorButton({
    super.key,
    required this.color,
    required this.mood,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(color),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1),
        ),
      ),
    );
  }
}
