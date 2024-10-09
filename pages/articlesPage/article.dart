import 'package:flutter/material.dart';
import '../singleArticlePage/singleArticlePage.dart';

class Article extends StatelessWidget {
  final String picture;
  final String title;
  final bool isLeft;
  final int textKey;

  const Article({
    required this.picture,
    required this.title,
    required this.isLeft,
    required this.textKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle styledText = const TextStyle(
      fontSize: 28,
      color: Colors.white,
      shadows: [
        Shadow(
          blurRadius: 6.0,
          color: Colors.black,
          offset: Offset(3, 3),
        ),
      ],
    );

    return Stack(
      children: [
        Image.asset(
          picture,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLeft)
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 46),
                      child: Text(
                        title,
                        style: styledText,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                // Button
                Container(
                  margin: EdgeInsets.only(
                    left: isLeft ? 0 : 16,
                    right: isLeft ? 16 : 16,
                    bottom: 16,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(_createRoute(title, picture));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white, width: 2)),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)),
                    ),
                    child: const Text(
                      'Читать',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                // Title positioned opposite to button
                if (!isLeft)
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Text(
                        title,
                        style: styledText,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Route _createRoute(String title, String picture) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SingleArticle(
        title: title,
        picture: picture,
        textKey: textKey,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

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
