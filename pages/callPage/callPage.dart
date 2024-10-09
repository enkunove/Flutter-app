import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/appbar.dart';
import '../../widgets/panel.dart';
import 'regionCall.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle numberStyle = const TextStyle(
        color: Colors.white,
        fontSize: 21,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white);
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
          Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 58),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Text(
                        "службы экстренной психологической помощи",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Телефоны доверия",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                        textAlign: TextAlign.center),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text("вы младше 18 лет",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17),
                          textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 017 263-03-03"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 017 263-03-03",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text("вы старше 18 лет",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17),
                          textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 017 352-44-44"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 017 352-44-44",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 017 202-04-01"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 017 202-04-01",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                          "Минский городской клинический центр психиатрии и психотерапии",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21),
                          textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 017 320-88-71"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 017 320-88-71",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 017 399-24-07"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 017 399-24-07",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text("Республиканская телефонная горячая линия",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21),
                          textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 801 100-16-11"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 801 100-16-11",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                          "Республиканский центр психологической помощи",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21),
                          textAlign: TextAlign.center),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "8 017 300-10-06"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован')),
                        );
                      },
                      style: const ButtonStyle(
                          overlayColor: WidgetStateColor.transparent),
                      child: Text("8 017 300-10-06",
                          style: numberStyle, textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Центры, дружественные подросткам",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                        textAlign: TextAlign.center),
                    const Text(
                      "для лиц младше 21 года (бесплатно, анонимно, конфиденциально)",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const RegionCall(title: "Центральный район\nцентр “Синяя птица”", num: "8 017 373-74-00"),
                    const RegionCall(title: "Фрунзенский район\nцентр “Юникс”", num: "8 017 209-85-61"),
                    const RegionCall(title: "Московский район\nцентр “Доверие”", num: "8 017 316-22-42"),
                    const RegionCall(title: "Заводской район\nцентр “Успех”", num: "8 017 307-20-39"),
                    const RegionCall(title: "Октябрьский район\nцентр “Галс”", num: "8 017 390-96-52"),
                    const RegionCall(title: "Партизанский район\nцентр “Визави”", num: "8 017 231-76-62"),
                    const RegionCall(title: "Первомайский район\nцентр “Вместе”", num: "8 017 258-86-39"),
                    const RegionCall(title: "Ленинский район\nцентр “Парус надежды”", num: "8 017 358-32-34"),
                    const RegionCall(title: "Советский район\nцентр “Ювентус”", num: "8 017 266-45-89"),
                    const SizedBox(
                      height: 120,
                    )
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
          const Align(
            child: MainPanel(),
          ),
        ],
      ),
    );
  }
}
