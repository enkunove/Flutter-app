import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainBar extends StatelessWidget {
  const MainBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  static const TextStyle style = TextStyle(
      color: Colors.white, fontSize: 13, textBaseline: TextBaseline.alphabetic);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
        child: Container(
      color: const Color.fromARGB(255, 80, 142, 192),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: const EdgeInsets.only(top: 0), child: Image.asset("lib/assets/logo2.png", width: 50, height: 50,),),
                      const Text("Easy psychology",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17))
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 20,),
          Padding(padding: const EdgeInsets.only(left: 20), child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white,),
                title: const Text('Главная', style: style),
                onTap: () {
                  Navigator.pushNamed(context, "/main");
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white,),
                title: const Text('Профиль', style: style),
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_answer_outlined, color: Colors.white,),
                title: const Text('Тесты', style: style),
                onTap: () {
                  Navigator.pushNamed(context, '/tests');
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month, color: Colors.white,),
                title: const Text('Календарь', style: style),
                onTap: () {
                  Navigator.pushNamed(context, "/calendar");
                },
              ),
              ListTile(
                leading: const Icon(Icons.article, color: Colors.white,),
                title: const Text('Статьи', style: style),
                onTap: () {
                  Navigator.pushNamed(context, '/articles');
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.white,),
                title: const Text('Контакты', style: style),
                onTap: () {
                  Navigator.pushNamed(context, '/contacts');
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                title: const Text('Выйти', style: style),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
