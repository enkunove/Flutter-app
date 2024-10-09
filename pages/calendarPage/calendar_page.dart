import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../source/calendar_logic.dart';
import '../../widgets/moodWidget.dart';
import '../../widgets/appbar.dart';
import '../../widgets/panel.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  final GlobalKey<MoodWidgetState> moodWidgetKey = GlobalKey<MoodWidgetState>();
  bool dayOpened = false, symptomsAdded = false;
  int chosenDay = DateTime.now().day;
  String month = DateFormat('MMM').format(DateTime.now());
  List<String> symptomedDays = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarLogic>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Colors.white,
        body: Stack(children: [
          Consumer<CalendarLogic>(
            builder: (context, calendarLogic, child) {
              List<Map<String, dynamic>> days = calendarLogic.generateCalendar(
                calendarLogic.currentDate.year,
                calendarLogic.currentDate.month,
              );
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeader(calendarLogic),
                  _buildCalendar(days, calendarLogic),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(child: _buildMoodWidget(calendarLogic)))
                ],
              );
            },
          ),
          Align(
              child: Container(
            child: const MainPanel(),
          )),
        ]));
  }

  Widget _buildHeader(CalendarLogic calendarLogic) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                const MainBar(),
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            calendarLogic.previousMonthCh();
                          },
                          icon: const Icon(Icons.arrow_circle_left, size: 30),
                        ),
                        Text(
                          DateFormat('MMMM yyyy')
                              .format(calendarLogic.currentDate),
                          style: const TextStyle(fontSize: 24),
                        ),
                        IconButton(
                          onPressed: () {
                            calendarLogic.nextMonthCh();
                          },
                          icon: const Icon(Icons.arrow_circle_right, size: 30),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(
      List<Map<String, dynamic>> days, CalendarLogic calendarLogic) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 300,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1,
          ),
          itemCount: days.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            var day = days[index];
            bool isSelected = day['day'] == chosenDay && day['isCurrentMonth'];
            String dayKey =
                "${day['day']}-${DateFormat('MMM').format(calendarLogic.currentDate)}-${calendarLogic.currentDate.year}";
            bool isSymptomedDay = calendarLogic.symptomedDays.contains(dayKey);
            Color dayColor = Colors.grey.shade300;
            if (day['isCurrentMonth']) {
              dayColor = calendarLogic.getDayColor(
                day['day'],
                calendarLogic.currentDate.month,
                calendarLogic.currentDate.year,
              );
            }

            return GestureDetector(
              onTap: day['isCurrentMonth']
                  ? () {
                      setState(() {
                        chosenDay = day['day'];
                        month =
                            DateFormat('MMM').format(calendarLogic.currentDate);
                        dayOpened = true;

                        Color moodColor = calendarLogic.getDayColor(
                          chosenDay,
                          calendarLogic.currentDate.month,
                          calendarLogic.currentDate.year,
                        );
                        moodWidgetKey.currentState?.updateColor(moodColor);
                      });
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: dayColor,
                  border: isSelected
                      ? Border.all(color: Colors.black, width: 2)
                      : Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day['day'].toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (day['isCurrentMonth'] && isSymptomedDay)
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          shape: BoxShape.circle,
                        ),
                      )
                  ],
                )),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMoodWidget(CalendarLogic calendarLogic) {
    return MoodWidget(
      key: moodWidgetKey,
      day: chosenDay,
      month: month,
      dayColor: calendarLogic.getDayColor(
        chosenDay,
        calendarLogic.currentDate.month,
        calendarLogic.currentDate.year,
      ),
      year: calendarLogic.currentDate.year,
      onColorChanged: (color) {
        calendarLogic.updateDayColor(
          chosenDay,
          calendarLogic.currentDate.month,
          calendarLogic.currentDate.year,
          color,
        );
      },
    );
  }
}
