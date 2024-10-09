import 'package:flutter/material.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/panel.dart';
import 'textHolder.dart';
import 'package:project/widgets/textbox.dart';

class SingleArticle extends StatelessWidget {
  final String title;
  final String picture;
  final int textKey;

  const SingleArticle(
      {super.key,
      required this.title,
      required this.picture,
      required this.textKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 139, 188, 228),
                  Color.fromARGB(255, 225, 232, 239)
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      picture,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120, left: 16),
                      child: Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AdaptiveTextBox(text: Textholder.text(textKey))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    side: WidgetStateProperty.all(const BorderSide(
                        color: Color.fromARGB(255, 88, 160, 219), width: 2)),
                    padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: const Text(
                    "Завершить",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 140))
              ],
            ),
          ),
          Align(
              child: Container(
                child: const MainPanel(),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: const MainBar(),
            ),
          ),
        ],
      ),
    );
  }
}
