import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project/pages/articlesPage/article.dart';
import 'package:project/widgets/articlesArray.dart';
import 'package:project/widgets/day.dart';
import 'package:project/widgets/panel.dart';
import 'package:project/widgets/appbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:project/widgets/testRecomendation.dart';
import 'package:intl/intl.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Article> chosenArt = <Article>[];
  final PageController _pageController = PageController();
  List<Article> arrcopy = List.from(articleArray);

  List<Article> rand() {
    chosenArt.clear();
    arrcopy.shuffle(Random());
    for (int n = 0; n < 4; n++) {
      chosenArt.add(arrcopy[n]);
    }
    return chosenArt;
  }

  int daysInMonth(DateTime date) {
    var nextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    return nextMonth.subtract(const Duration(days: 1)).day;
  }


  @override
  void initState() {
    super.initState();
    rand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
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
                    PageView.builder(
                      controller: _pageController,
                      itemCount: chosenArt.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var article = chosenArt[index];
                        return Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Container(
                              color: Colors.black,
                            ),
                            Image.asset(
                              article.picture,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 80),
                                  child: Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 6.0,
                                          color: Colors.black.withOpacity(1),
                                          offset: const Offset(3, 3),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/articles");
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      side: WidgetStateProperty.all(
                                          const BorderSide(
                                              color: Colors.white, width: 2)),
                                      padding: WidgetStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8)),
                                    ),
                                    child: const Text(
                                      "Читать",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    Align(
                      alignment: const Alignment(0.0, -0.43),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: chosenArt.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.white.withOpacity(0.5),
                          dotHeight: 10,
                          dotWidth: 10,
                          expansionFactor: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent == 1.0 || notification.extent == 0.25) {
                return true;
              }
              return false;
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.69,
              minChildSize: 0.69,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 139, 188, 228),
                        Color.fromARGB(255, 225, 232, 239)
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 0),
                              width: 30,
                              height: 5,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 107, 143, 172),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 20),
                              child: (Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DayButton(
                                    day: DateTime.now().day,
                                    month: DateFormat('MMM').format(DateTime.now()),
                                    isActive: true,
                                    color: Colors.white,
                                  ),
                                  DayButton(
                                      day: DateTime.now().day + 1,
                                      month: DateTime.now().day + 1 <= daysInMonth(DateTime.now())
                                          ? DateFormat('MMM').format(DateTime.now())
                                          : DateFormat('MMM').format(
                                        DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month + 1,
                                        ),
                                      ),
                                      isActive: false,
                                      color: Colors.white),
                                  DayButton(
                                      day: DateTime.now().day + 2,
                                      month: DateTime.now().day + 2 <= daysInMonth(DateTime.now())
                                          ? DateFormat('MMM').format(DateTime.now())
                                          : DateFormat('MMM').format(
                                        DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month + 1,
                                        ),
                                      ),
                                      isActive: false,
                                      color: Colors.white),
                                  DayButton(
                                      day: DateTime.now().day + 3,
                                      month: DateTime.now().day + 3 <= daysInMonth(DateTime.now())
                                          ? DateFormat('MMM').format(DateTime.now())
                                          : DateFormat('MMM').format(
                                        DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month + 1,
                                        ),
                                      ),
                                      isActive: false,
                                      color: Colors.white),
                                ],
                              )),
                            ),
                            Text(
                              "Возможно Вам будет интересно: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6.0,
                                    color: Colors.black.withOpacity(1),
                                    offset: const Offset(3, 3),
                                  ),
                                ],
                              ),
                            ),
                            const Test(
                                title: "Шкала депрессии Бека",
                                picture: "lib/assets/tests/depr2.png",
                                amount: 21,
                                url: "https://psytests.org/depr/bdi-run.html",
                            ),
                            const Test(
                                title: "Диагностика уровня эмоционального выгорания",
                                picture: "lib/assets/tests/vygor2.png",
                                amount: 84,
                                url: "https://psytests.org/boyko/boburn-run.html",
                            ),
                            const Test(
                                title: "Торонтская алекситимическая шкала",
                                picture: "lib/assets/tests/ale3.png",
                                amount: 26,
                                url: "https://psytests.org/diag/tas26-run.html",
                            ),
                            const Test(
                              title: "Вендер-Ютская шкала самооценки СДВГ у взрослых",
                              picture: "lib/assets/tests/СДВГ.jpg",
                              amount: 25,
                              url: "https://psytests.org/diag/wurs-run.html",
                            ),
                            const SizedBox(height: 70,)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: const MainBar(),
            ),
          ),
          Align(
              child: Container(
            child: const MainPanel(),
          ))
        ],
      ),
    );
  }
}
