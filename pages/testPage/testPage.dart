import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:project/widgets/panel.dart';
import 'package:project/widgets/appbar.dart';

import '../../source/storage_service.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late final WebViewController _controller;
  late StorageService storageService;
  bool isLoading = true;
  bool onButton = false;
  String title = '';
  String url = '';
  int testsCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as List?;
    if (args != null) {
      setState(() {
        title = args[0];
        url = args[1];
        _initializeWebView();
      });
    }
  }

  void _initializeWebView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storageService = StorageService(prefs);
    testsCount = await storageService.loadTests();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..clearCache()
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              isLoading = false;
            });

            if (url.contains('-run.html')) {
              await _controller.runJavaScript('''
                var element = document.getElementById('stdRun');
                if (element) {
                  document.body.innerHTML = element.outerHTML;
                }
              ''');
            } else if (url.contains('_')) {
              await _controller.runJavaScript('''
                var element = document.getElementById('qtlTest');
                if (element) {
                  document.body.innerHTML = element.outerHTML;
                }
              ''');
            } else if (url.contains('result')) {
              await _controller.runJavaScript('''
    var elements = document.getElementsByClassName('resBody');
    if (elements.length > 0) {
      var nacWide = document.getElementById('nac_wide');
      if (nacWide) {
        nacWide.remove();
      }
      document.body.innerHTML = elements[0].outerHTML;
    }
  ''');
              onButton = true;
              testsCount++;
              await storageService.saveTests(testsCount);
            }
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 60, left: 60, top: 48),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, right: 10, left: 10),
                      child: WebViewWidget(controller: _controller),
                    ),
                  ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: const MainBar(),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: MainPanel(),
            ),
          ],
        ),
      ),
    );
  }
}
