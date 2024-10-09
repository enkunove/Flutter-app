import 'package:flutter/material.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/testRecomendation.dart';
import '../../widgets/panel.dart';

class TestRecomendationPage extends StatelessWidget {
  final List<Test> testsArray;
  const TestRecomendationPage({super.key, required this.testsArray});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(children: [
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
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 90,
              ),
              const Text("Рекомендуемые тесты на сегодня:",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  textAlign: TextAlign.center),
              for (Test i in testsArray) i,
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white30),
                    side: WidgetStateProperty.all(
                        const BorderSide(color: Colors.black, width: 1)),
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8)),
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                    child: Text(
                      "Не сейчас",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  )),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        )),
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
      ]),
    );
  }
}
