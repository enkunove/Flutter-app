import 'package:flutter/material.dart';
import 'package:project/source/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/symptomsPage/symptomsPage.dart';
import '../widgets/colorButtons.dart';

class MoodWidget extends StatefulWidget {
  final int day;
  final String month;
  final Color dayColor;
  final int year;
  final ValueChanged<Color> onColorChanged;

  const MoodWidget({
    super.key,
    required this.day,
    required this.month,
    required this.dayColor,
    required this.year,
    required this.onColorChanged,
  });

  @override
  State<MoodWidget> createState() => MoodWidgetState();
}

class MoodWidgetState extends State<MoodWidget> {
  late Color moodColor;
  StorageService? _storageService;

  @override
  void initState() {
    super.initState();
    moodColor = widget.dayColor;
    _initStorageService();
  }

  Future<void> _initStorageService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storageService = StorageService(prefs);
    });
  }

  void updateColor(Color newColor) {
    setState(() {
      moodColor = newColor;
    });
    widget.onColorChanged(newColor);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 139, 188, 228),
              Color.fromARGB(255, 225, 232, 239),
            ],
          ),
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        height: 400,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 137,
                  width: 90,
                  decoration: BoxDecoration(
                    color: moodColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 73, 73, 73),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 117,
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
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.day.toString(),
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 107, 143, 172),
                            ),
                          ),
                          Text(
                            widget.month,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 107, 143, 172),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Отметьте свое настроение",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 1.0,
                            color: Colors.black54,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ColorButton(
                          color: Colors.green,
                          mood: " Отлично ",
                          onTap: updateColor,
                        ),
                        const SizedBox(width: 8),
                        ColorButton(
                          color: Colors.blue,
                          mood: " Нейтрально ",
                          onTap: updateColor,
                        ),
                        const SizedBox(width: 8),
                        ColorButton(
                          color: Colors.orange,
                          mood: " Тревожно ",
                          onTap: updateColor,
                        ),
                        const SizedBox(width: 8),
                        ColorButton(
                          color: Colors.yellow,
                          mood: " Раздражен ",
                          onTap: updateColor,
                        ),
                        const SizedBox(width: 8),
                        ColorButton(
                          color: Colors.red,
                          mood: " Зол/огорчен ",
                          onTap: updateColor,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_storageService != null) {
                  Navigator.of(context).push(_createSlideFromBottomRoute());
                } else {
                  print("StorageService is not ready yet.");
                }
              },
              child: const Text("Добавить симптомы",
                  style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }

  Route _createSlideFromBottomRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => SymptomsPage(
        dateDay: widget.day,
        dateMonth: widget.month,
        dateYear: widget.year,
        storageService: _storageService!,
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
