import 'package:flutter/material.dart';
import 'package:simply_halal/widgets/big_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MenuScreen extends StatefulWidget {
  String menuUrl;

  MenuScreen({Key? key, required this.menuUrl}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoading = true;
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          WebView(
            initialUrl: widget.menuUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
          ),
          loadingPercentage < 100
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack()
        ],
      )),
    );
  }
}
