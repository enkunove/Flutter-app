import 'package:flutter/material.dart';
import 'package:project/source/storage_service.dart';
import 'package:project/widgets/moodWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../source/calendar_logic.dart';
import '../../widgets/appbar.dart';
import '../../widgets/panel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<MoodWidgetState> moodWidgetKey = GlobalKey<MoodWidgetState>();
  late StorageService storageService;
  int symptomsCount = 0, moodsCount = 0, testsCount = 0;

  Future<void> _initializeStorageService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storageService = StorageService(prefs);
    symptomsCount = await storageService.calculateCalendarSymptoms();
    moodsCount = await storageService.calculateCalendarMoods();
    testsCount = await storageService.loadTests();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializeStorageService();
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
          SingleChildScrollView(
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      "lib/assets/logo2.png",
                      width: 150,
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Профиль пользователя\nEasy Psychology",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      height: 3,
                      width: 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Статистика:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black.withOpacity(0.6),
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Дней с отмеченным настроением: $moodsCount",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                        "Дней с отмеченными симптомами: $symptomsCount",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 30),
                      child: Text(
                        "Пройдено тестов: $testsCount",
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 3,
                      width: 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Информация:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black.withOpacity(0.6),
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 30),
                      child: Text(
                        "Тесты взяты с открытого информационного интернет-ресурса psytests.org.\nРезультаты и интерпретации, полученные без участия специалистов, не следует воспринимать слишком серьезно. Диагностическую ценность имеют только исследования, проведенные профессиональным психологом.",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 3,
                      width: 300,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final storageService = StorageService(prefs);
                        await storageService.wipeData();
                        Provider.of<CalendarLogic>(context, listen: false)
                            .resetColors();
                        moodWidgetKey.currentState?.updateColor(Colors.white);
                        setState(() {
                          symptomsCount = 0;
                          testsCount = 0;
                          moodsCount = 0;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Данные очищены")),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        side: WidgetStateProperty.all(
                            const BorderSide(color: Colors.white, width: 2)),
                        padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8)),
                        elevation: WidgetStateProperty.all(0),
                      ),
                      child: Text(
                        "Удалить сохраненные данные",
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                )),
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
