import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(20.0),
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  border: Border.all(
                    color: const Color.fromARGB(255, 73, 73, 73),
                    width: 3,
                  ),
                )
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/panel/home.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/main");
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/panel/phone.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/call");
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/panel/man.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
