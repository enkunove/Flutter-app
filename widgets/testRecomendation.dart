import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final String title, picture, url;
  final int amount;

  const Test(
      {super.key,
      required this.title,
      required this.picture,
      required this.amount,
      required this.url});

  @override
  Widget build(BuildContext context) {
    Set<String> rawdata = {title, url};
    List data = rawdata.toList();
    return Center(
      child: Container(
        padding:
            const EdgeInsets.only(right: 20.0, left: 20, top: 30, bottom: 30),
        margin: const EdgeInsets.only(top: 20.0, right: 30, left: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(2, 4),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              picture,
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 58, 70, 99),
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                  Text("$amount вопрос(ов)"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/test', arguments: data);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(const BorderSide(
                          color: Color.fromARGB(255, 139, 188, 228), width: 2)),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: const Text("Пройти тест",
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
