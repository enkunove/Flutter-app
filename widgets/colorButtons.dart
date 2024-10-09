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
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            onTap(color);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(40, 40),
          ),
          child: Container(),
        ),
        Text(
          mood,
          style: const TextStyle(fontSize: 8),
        ),
      ],
    );
  }
}
