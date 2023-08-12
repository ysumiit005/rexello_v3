import "package:flutter/material.dart";
// import 'package:rexello_tests_only_home/globals/device_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../globals/custom_app_bar.dart';
import '../../globals/device_size.dart';
import '../drawer/custom_drawer.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AboutUsWebViewScreen(
        rexUrl: '',
        title: '',
      ),
    ),
  );
}

class AboutUsWebViewScreen extends StatefulWidget {
  const AboutUsWebViewScreen({
    super.key,
    required this.title,
    required this.rexUrl,
  });

  final String title;
  final String rexUrl;

  @override
  State<AboutUsWebViewScreen> createState() => _AboutUsWebViewScreenState();
}

class _AboutUsWebViewScreenState extends State<AboutUsWebViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final WebViewController controller;

  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.rexUrl),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }, onNavigationRequest: (request) {
        if (request.url.startsWith('tel:')) {
          launch(request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            //
            // custom app bar
            //
            CustomAppBar(
              scaffoldKey: _scaffoldKey,
              title: widget.title,
            ),
            Flexible(
              child: Stack(
                children: [
                  //
                  // webview
                  //
                  WebViewWidget(
                    controller: controller,
                  ),
                  if (loadingPercentage < 100)
                    Container(
                      height: DeviceSize.height,
                      width: DeviceSize.width,
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  // LinearProgressIndicator(
                  //   value: loadingPercentage / 100.0,
                  // ),
                ],
              ),
            ),
          ],
        ),
        endDrawer: const CustomDrawer(),
      ),
    );
  }
}
