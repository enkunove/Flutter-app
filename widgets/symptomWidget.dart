import 'package:flutter/material.dart';

class Symptom extends StatelessWidget {
  final String symptom;
  final Function(String) onSelected;
  final bool isSelected;

  const Symptom({
    super.key,
    required this.symptom,
    required this.onSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<String> words = symptom.split(' ');
    String displayedSymptom = words.length > 2
        ? '${words.sublist(0, 2).join(' ')}\n${words.sublist(2).join(' ')}'
        : symptom;

    return GestureDetector(
      onTap: () {
        onSelected(symptom);
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.black : Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: isSelected ? Colors.blue.withOpacity(0.2) : const Color.fromARGB(255, 143, 190, 229),
        ),
        child: Text(
          displayedSymptom,
          style: TextStyle(color: isSelected ? Colors.black : Colors.white),
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}



