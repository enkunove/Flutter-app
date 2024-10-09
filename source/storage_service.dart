import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<void> saveSymptoms(List<Map<String, dynamic>> addedDays) async {
    try {
      List<String> jsonList = addedDays.map((day) {
        return json.encode(day);
      }).toList();
      await prefs.setStringList('addedDays', jsonList);
    } catch (e) {
      print("Error saving Symptoms: $e");
    }
  }

  Future<int> calculateCalendarSymptoms() async {
    int res = 0;
    List<String>? symptoms = prefs.getStringList('addedDays');
    if (symptoms != null) {
      for (var i in symptoms) {
        res++;
      }
    }
    return res;
  }

  Future<int> calculateCalendarMoods() async {
    int res = 0;
    List<String>? moods = prefs.getStringList('coloredDays');
    if (moods != null) {
      for (var i in moods) {
        res++;
      }
    }
    return res;
  }

  Future<List<Map<String, dynamic>>> loadSymptoms() async {
    try {
      List<String>? jsonList = prefs.getStringList('addedDays');
      if (jsonList != null) {
        return jsonList
            .map((dayString) => json.decode(dayString))
            .toList()
            .cast<Map<String, dynamic>>();
      } else {
        print("No saved symptom data found.");
        return [];
      }
    } catch (e) {
      print("Error loading added days: $e");
      return [];
    }
  }

  Future<void> saveColoredDays(List<Map<String, dynamic>> coloredDays) async {
    try {
      List<String> jsonList = coloredDays.map((day) {
        return json.encode(day);
      }).toList();
      await prefs.setStringList('coloredDays', jsonList);
    } catch (e) {
      print("Error saving colored days: $e");
    }
  }

  Future<void> saveTests(int tests) async {
    try {
      await prefs.setInt('testsCount', tests);
    } catch (e) {
      print("Error saving tests amount: $e");
    }
  }

  Future<int> loadTests() async {
    int? tests = 0;
    try {
      tests = prefs.getInt('testsCount');
    } catch (e) {
      print("Error loading tests amount: $e");
    }
    if (tests != null) {
      return tests;
    } else {
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> loadColoredDays() async {
    try {
      List<String>? jsonList = prefs.getStringList('coloredDays');
      if (jsonList != null) {
        return jsonList
            .map((dayString) => json.decode(dayString))
            .toList()
            .cast<Map<String, dynamic>>();
      } else {
        print("No saved color data found.");
        return [];
      }
    } catch (e) {
      print("Error loading colored days: $e");
      return [];
    }
  }

  Future<void> wipeData() async {
    try {
      await prefs.remove('coloredDays');
      await prefs.remove('addedDays');
      await prefs.setInt('testsCount', 0);
      print("Data wiped.");
    } catch (e) {
      print("Error wiping data: $e");
    }
  }
}
