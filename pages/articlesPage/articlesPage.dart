import 'package:flutter/material.dart';
import 'package:project/widgets/articlesArray.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/panel.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                for (var article in articleArray) article,
                Container(
                  color: Colors.white,
                  height: 3,
                  width: 300,
                ),
                const SizedBox(height: 66)
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
          Align(
              child: Container(
            child: const MainPanel(),
          ))
        ],
      ),
    );
  }
}
