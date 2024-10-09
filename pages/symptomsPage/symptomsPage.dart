import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/pages/testRecPage/testRecPage.dart';
import 'package:project/source/testRecomendationScript.dart';
import 'package:project/widgets/symptomWidget.dart';
import 'package:project/source/storage_service.dart';
import '../../widgets/appbar.dart';
import '../../widgets/panel.dart';
import '../calendarPage/calendar_page.dart';

class SymptomsPage extends StatefulWidget {
  final int dateDay;
  final String dateMonth;
  final int dateYear;
  final StorageService storageService;

  const SymptomsPage({
    super.key,
    required this.dateDay,
    required this.dateMonth,
    required this.dateYear,
    required this.storageService,
  });

  @override
  State<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  final GlobalKey<CalendarPageState> calendarPageKey =
      GlobalKey<CalendarPageState>();
  Map<String, List<String>> data = {};
  List<String> selectedSymptoms = [];
  late int day;
  late String month;
  late int year;

  @override
  void initState() {
    super.initState();
    day = widget.dateDay;
    month = widget.dateMonth;
    year = widget.dateYear;
    _loadSymptomsForDay();
  }

  Future<void> _loadSymptomsForDay() async {
    String dateKey = "$day-$month-$year";

    List<Map<String, dynamic>> loadedSymptoms =
        await widget.storageService.loadSymptoms();

    data = {
      for (var entry in loadedSymptoms)
        entry["date"] as String: List<String>.from(entry["symptoms"])
    };

    setState(() {
      selectedSymptoms = data[dateKey] ?? [];
    });
  }

  void toggleSymptomSelection(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  Future<void> saveSymptoms() async {
    String dateKey = "$day-$month-$year";
    data[dateKey] = selectedSymptoms;

    List<Map<String, dynamic>> formattedData = data.entries.map((entry) {
      return {
        "date": entry.key,
        "symptoms": entry.value,
      };
    }).toList();
    await widget.storageService.saveSymptoms(formattedData);
    if (selectedSymptoms.isNotEmpty) {
      print("Symptoms saved for $dateKey: $selectedSymptoms");
      Navigator.of(context).push(_createSlideFromBottomRoute());
    }
  }

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
          Column(
            children: [
              const SizedBox(
                height: 48,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "$day $month $year",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 84, 111, 133),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 12,
                              offset: const Offset(3, 6),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Изменение аппетита",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Изменение аппетита"),
                                ),
                                Symptom(
                                  symptom: "Навязчивые мысли",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Навязчивые мысли"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Снижение концентрации",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Снижение концентрации"),
                                ),
                                Symptom(
                                  symptom: "Утомляемость",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Утомляемость"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Истощение",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Истощение"),
                                ),
                                Symptom(
                                  symptom: "Усталость",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Усталость"),
                                ),
                                Symptom(
                                  symptom: "Нарушения сна",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Нарушения сна"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Безразличие к задачам",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Безразличие к задачам"),
                                ),
                                Symptom(
                                  symptom: "Гиперактивность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Гиперактивность"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Потеря интереса к работе",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Потеря интереса к работе"),
                                ),
                                Symptom(
                                  symptom: "Затруднения в передаче состояния",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms.contains(
                                      "Затруднения в передаче состояния"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Снижение работоспособности",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Снижение работоспособности"),
                                ),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Амнезия",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Амнезия"),
                                ),
                                Symptom(
                                  symptom: "Нарушение восприятия",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Нарушение восприятия"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Нарушение внимания",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Нарушение внимания"),
                                ),
                                Symptom(
                                  symptom: "Нарушения речи",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Нарушения речи"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Повышенная импульсивность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Повышенная импульсивность"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Отсутствие удовольствия",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Отсутствие удовольствия"),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Symptom(
                                    symptom: "Сниженное настроение",
                                    onSelected: toggleSymptomSelection,
                                    isSelected: selectedSymptoms
                                        .contains("Сниженное настроение"),
                                  ),
                                  Symptom(
                                    symptom: "Смены настроения",
                                    onSelected: toggleSymptomSelection,
                                    isSelected: selectedSymptoms
                                        .contains("Смены настроения"),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Symptom(
                                    symptom: "Изменения в поведении",
                                    onSelected: toggleSymptomSelection,
                                    isSelected: selectedSymptoms
                                        .contains("Изменения в поведении"),
                                  ),
                                  Symptom(
                                    symptom: "Фобии",
                                    onSelected: toggleSymptomSelection,
                                    isSelected:
                                        selectedSymptoms.contains("Фобии"),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Symptom(
                                    symptom: "Нестабильность",
                                    onSelected: toggleSymptomSelection,
                                    isSelected: selectedSymptoms
                                        .contains("Нестабильность"),
                                  ),
                                  Symptom(
                                    symptom: "Нарушения сна",
                                    onSelected: toggleSymptomSelection,
                                    isSelected: selectedSymptoms
                                        .contains("Нарушения сна"),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Symptom(
                                    symptom: "Флешбэки",
                                    onSelected: toggleSymptomSelection,
                                    isSelected:
                                        selectedSymptoms.contains("Флешбэки"),
                                  ),
                                  Symptom(
                                    symptom: "Триггеры",
                                    onSelected: toggleSymptomSelection,
                                    isSelected:
                                        selectedSymptoms.contains("Триггеры"),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Страх",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Страх"),
                                ),
                                Symptom(
                                  symptom: "Перепады настроения",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Перепады настроения"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Плаксивость",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Плаксивость"),
                                ),
                                Symptom(
                                  symptom: "Раздражительность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Раздражительность"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Пониженное настроение",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Пониженное настроение"),
                                ),
                                Symptom(
                                  symptom: "Нарушения сна",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Нарушения сна"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Слабость",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Слабость"),
                                ),
                                Symptom(
                                  symptom: "Снижение интересов",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Снижение интересов"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Головная боль",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Головная боль"),
                                ),
                                Symptom(
                                  symptom: "Ощущение кома",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Ощущение кома"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Боли",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms.contains("Боли"),
                                ),
                                Symptom(
                                  symptom: "Вегетативные симптомы",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Вегетативные симптомы"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Неуверенность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Неуверенность"),
                                ),
                                Symptom(
                                  symptom: "Пассивность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Пассивность"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Несамостоятельность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Несамостоятельность"),
                                ),
                                Symptom(
                                  symptom: "Инфантилизм",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Инфантилизм"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Агрессивность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Агрессивность"),
                                ),
                                Symptom(
                                  symptom: "Низкая самооценка",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Низкая самооценка"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Боязнь общения",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Боязнь общения"),
                                ),
                                Symptom(
                                  symptom: "Эгоизм",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Эгоизм"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Эмоциональные реакции",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Эмоциональные реакции"),
                                ),
                                Symptom(
                                  symptom: "Истощение",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Истощение"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Рассеянность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Рассеянность"),
                                ),
                                Symptom(
                                  symptom: "Память",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Память"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Самоконтроль",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Самоконтроль"),
                                ),
                                Symptom(
                                  symptom: "Стресс",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Стресс"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Импульсивность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Импульсивность"),
                                ),
                                Symptom(
                                  symptom: "Фрустрация",
                                  onSelected: toggleSymptomSelection,
                                  isSelected:
                                      selectedSymptoms.contains("Фрустрация"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Symptom(
                                  symptom: "Растерянность",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Растерянность"),
                                ),
                                Symptom(
                                  symptom: "Нарушение мышления",
                                  onSelected: toggleSymptomSelection,
                                  isSelected: selectedSymptoms
                                      .contains("Нарушение мышления"),
                                ),
                              ],
                            ),
                          ],
                        ))),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      saveSymptoms();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 143, 190, 229)),
                      side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.black, width: 1)),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      child: Text(
                        "Добавить",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
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
            ),
          ),
        ],
      ),
    );
  }

  Route _createSlideFromBottomRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) =>
          TestRecomendationPage(
        testsArray:
            Generate(selectedSymptoms).matchesSymptoms(selectedSymptoms),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutQuad;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var slideAnimation = animation.drive(tween);

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
    );
  }
}
