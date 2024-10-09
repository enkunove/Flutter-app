import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'testRecomendation.dart';

class TestSelectorWidget extends StatefulWidget {
  final String title;
  final List<Test> tests;

  const TestSelectorWidget(
      {super.key, required this.title, required this.tests});

  @override
  State<TestSelectorWidget> createState() => _TestSelectorWidgetState();
}

class _TestSelectorWidgetState extends State<TestSelectorWidget> {
  final PageController _pageController = PageController(viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: const Color.fromARGB(255, 142, 171, 215),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: const TextStyle(color: Colors.white, fontSize: 23),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.tests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Transform.scale(
                    scale: 1,
                    child: widget.tests[index],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _pageController,
            count: widget.tests.length,
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.white,
              dotColor: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
