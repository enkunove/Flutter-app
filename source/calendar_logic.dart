import 'package:flutter/material.dart';
import 'package:project/source/storage_service.dart';

class CalendarLogic with ChangeNotifier {
  DateTime currentDate = DateTime.now();
  Map<String, Color> dayColors = {};
  List symptomedDays = [];
  List<Map<String, dynamic>> coloredDays = [];
  final StorageService storageService;

  CalendarLogic(this.storageService) {
    initialize();
  }

  String _generateKey(int day, int month, int year) {
    return "$year-$month-$day";
  }

  Future<void> initialize() async {
    await _loadColoredDays();
    addSymptomedDays();
    notifyListeners();
  }

  Future<void> updateDayColor(int day, int month, int year, Color color) async {
    String key = _generateKey(day, month, year);
    dayColors[key] = color;

    String encodedColor = '0x${color.value.toRadixString(16).padLeft(8, '0')}';
    var existingDay = coloredDays.firstWhere(
      (item) =>
          item['day'] == day && item['month'] == month && item['year'] == year,
      orElse: () => {'day': null},
    );
    if (encodedColor == '0xffffffff') return;
    if (existingDay['day'] != null) {
      existingDay['color'] = encodedColor;
    } else {
      coloredDays.add({
        'day': day,
        'month': month,
        'year': year,
        'color': encodedColor,
      });
    }

    await _saveColoredDays();
    notifyListeners();
  }

  void addSymptomedDays() async {
    List<Map<String, dynamic>> loadedSymptoms =
        await storageService.loadSymptoms();
    for (var data in loadedSymptoms) {
      if (!symptomedDays.contains(data["date"])) {
        symptomedDays.add(data["date"]);
      }
    }
    print(symptomedDays);
  }

  Future<void> _saveColoredDays() async {
    await storageService.saveColoredDays(coloredDays);
  }

  Future<void> _loadColoredDays() async {
    coloredDays = await storageService.loadColoredDays();
    updateColors();
  }

  void updateSymptomsStatus() {
    for (var day in symptomedDays) {
      int dayValue = day['day'];
      int monthValue = day['month'];
      int yearValue = day['year'];
      String key = _generateKey(dayValue, monthValue, yearValue);
    }
  }

  void updateColors() {
    for (var day in coloredDays) {
      int dayValue = day['day'];
      int monthValue = day['month'];
      int yearValue = day['year'];

      String colorString = day['color'];
      if (colorString.startsWith('0x')) {
        colorString = colorString.substring(2);
      }

      int hexValue = int.parse(colorString, radix: 16);
      Color color = Color(hexValue);
      updateDayColor(dayValue, monthValue, yearValue, color);
    }
    notifyListeners();
  }

  Color getDayColor(int day, int month, int year) {
    String key = _generateKey(day, month, year);
    return dayColors[key] ?? Colors.white;
  }

  void resetColors() {
    symptomedDays.clear();
    dayColors.clear();
    coloredDays.clear();
    storageService.wipeData();
    notifyListeners();
  }

  int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int firstDayOfMonth(int year, int month) {
    return DateTime(year, month, 1).weekday;
  }

  void nextMonthCh() {
    if (currentDate.month == 12) {
      currentDate = DateTime(currentDate.year + 1, 1);
    } else {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    }
    notifyListeners();
  }

  void previousMonthCh() {
    if (currentDate.month == 1) {
      currentDate = DateTime(currentDate.year - 1, 12);
    } else {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> generateCalendar(int year, int month) {
    List<Map<String, dynamic>> days = [];
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    int previousMonthDays = firstDayOfMonth.weekday - 1;
    int nextMonthDays = 7 - lastDayOfMonth.weekday;

    DateTime prevMonth = DateTime(year, month - 1);
    int lastDayPrevMonth = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    for (int i = 0; i < previousMonthDays; i++) {
      days.add({
        'day': lastDayPrevMonth - previousMonthDays + i + 1,
        'isCurrentMonth': false,
        'colored': false,
      });
    }

    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add({
        'day': i,
        'isCurrentMonth': true,
        'colored': true,
      });
    }

    for (int i = 1; i <= nextMonthDays; i++) {
      days.add({
        'day': i,
        'isCurrentMonth': false,
        'colored': false,
      });
    }

    return days;
  }
}
