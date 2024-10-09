import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegionCall extends StatelessWidget {
  final String title;
  final String num;
  const RegionCall({super.key, required this.title, required this.num});

  @override
  Widget build(BuildContext context) {
    TextStyle numberStyle = const TextStyle(
        color: Colors.white,
        fontSize: 21,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 21),
              textAlign: TextAlign.center),
        ),
        TextButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: num));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Номер скопирован')),
            );
          },
          style: const ButtonStyle(overlayColor: WidgetStateColor.transparent),
          child: Text(num, style: numberStyle, textAlign: TextAlign.center),
        ),
        Container(
          color: Colors.white,
          height: 3,
          width: 300,
        ),
      ],
    );
  }
}
