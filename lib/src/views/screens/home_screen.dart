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
  bool showErrorPage = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
                color: Colors.green,
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : SizedBox.shrink(),
              ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      initialUrl: Links.link,
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                        ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      onLoadStart:
                          (InAppWebViewController controller, String url) {
                        setState(() {
                          this.url = url;
                        });
                      },
                      onLoadStop: (InAppWebViewController controller,
                          String url) async {
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
                      ////
                      ///
                      ///
                      ///
                      ///

                      onLoadError: (InAppWebViewController controller,
                          String url, int i, String s) async {
                        print('CUSTOM_HANDLER: $i, $s');
                        showError();
                      },
                      onLoadHttpError: (InAppWebViewController controller,
                          String url, int i, String s) async {
                        print('CUSTOM_HANDLER: $i, $s');
                        showError();
                      },
                    ),
                    showErrorPage
                        ? Center(
                            child: Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                              child: Container(
                                height: 200.0,
                                width: 200.0,
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    "Creer un widget encas d'erreur de chargemen de la page",
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(height: 0, width: 0),
                  ],
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

  void showError() {
    setState(() {
      showErrorPage = true;
    });
  }

  void hideError() {
    setState(() {
      showErrorPage = false;
    });
  }
}
