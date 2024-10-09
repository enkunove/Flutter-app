import 'package:flutter/material.dart';
import 'package:project/widgets/testSelectorWidget.dart';
import 'package:project/widgets/panel.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/source/testsHolder.dart';

class TestChoosingPage extends StatelessWidget {
  const TestChoosingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 139, 188, 228),
                    Color.fromARGB(255, 225, 232, 239),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            // Added scrolling for long content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 48.0),
                    child: const Text(
                      "Каталог тестов",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на депрессию",
                    tests: depressionTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на эмоциональное выгорание",
                    tests: burnoutTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на алекситемию",
                    tests: aleksitimiaTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на СДВГ",
                    tests: sdvgTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на якоря карьеры",
                    tests: careerTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на эмпатию",
                    tests: empatiaTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на дистимию",
                    tests: distTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на ПТСР",
                    tests: ptsrTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на тревожность",
                    tests: trevTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на уверенность в себе",
                    tests: neuverennostTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на напряженность",
                    tests: napryazhenieTests,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TestSelectorWidget(
                    title: "Тесты на устойчивость",
                    tests: ustoichTests,
                  ),
                ),

                const SizedBox(height: 80,)
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: const MainBar(),
            ),
          ),
          const Align(
            child: MainPanel(),
          ),
        ],
      ),
    );
  }
}
