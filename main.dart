import 'package:flutter/material.dart';
import 'package:project/pages/callPage/callPage.dart';
import 'package:project/pages/symptomsPage/symptomsPage.dart';
import 'package:project/pages/testsSelectorPage/testsSelectorPage.dart';
import 'package:project/source/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/source/calendar_logic.dart';
import 'package:provider/provider.dart';
import 'package:project/pages/mainPage/mainPage.dart';
import 'package:project/pages/articlesPage/articlesPage.dart';
import 'package:project/pages/calendarPage/calendar_page.dart';
import 'package:project/pages/profilePage/profilePage.dart';
import 'package:project/pages/testPage/testPage.dart';
import 'package:project/widgets/callWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  StorageService storageService = StorageService(prefs);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalendarLogic(storageService)),
      ],
      child: MyApp(storageService: storageService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final StorageService storageService;

  const MyApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainPage(),
        '/articles': (context) => const ArticlePage(),
        '/calendar': (context) => const CalendarPage(),
        '/test': (context) => const TestPage(),
        '/call': (context) => const CallWidget(),
        '/profile': (context) => const Profile(),
        '/tests': (context) => const TestChoosingPage(),
        '/symptoms': (context) => SymptomsPage(
              storageService: storageService,
              dateDay: 1,
              dateMonth: 'January',
              dateYear: 2000,
            ),
        '/contacts': (context) => const CallPage(),
      },
    );
  }
}
