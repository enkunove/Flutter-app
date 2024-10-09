import 'package:flutter/material.dart';

class DayButton extends StatelessWidget {
  final int day;
  final String month;
  final bool isActive;
  final Color color;

  const DayButton({
    super.key,
    required this.day,
    required this.month,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 127 : 95,
      width: 75,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 139, 188, 228),
              Color.fromARGB(255, 225, 232, 239),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 73, 73, 73),
            width: 0.6,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: 12,
              offset: const Offset(3, 6),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.toString(),
            style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 107, 143, 172)),
          ),
          Text(
            month,
            style: const TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 107, 143, 172)),
          ),
          if (isActive)
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                icon: const Icon(Icons.add_circle_rounded))
        ],
      ),
    );
  }
}
