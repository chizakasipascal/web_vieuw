import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inoselsweb/src/data/network/link.dart';

class WebViewInosels extends StatefulWidget {
  @override
  _WebViewInoselsState createState() => new _WebViewInoselsState();
}

class _WebViewInoselsState extends State<WebViewInosels> {
  InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : SizedBox.fromSize(),
              ),
              Expanded(
                child: InAppWebView(
                  initialUrl: Links.link,
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController.goBack();
                }
              },
            ),
            FlatButton(
              child: Icon(Icons.arrow_forward),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController.goForward();
                }
              },
            ),
            FlatButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController.reload();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
