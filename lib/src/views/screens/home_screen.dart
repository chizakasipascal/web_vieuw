import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inoselsweb/src/data/network/link.dart';
import 'package:inoselsweb/src/views/widgets/naviation_refresh.dart';
import 'package:inoselsweb/utils/colors.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: progress < 1.0
                  ? LinearProgressIndicator(
                      value: progress,
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                      minHeight: 1,
                      backgroundColor: WhiteColor,
                    )
                  : SizedBox.shrink(),
            ),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrl: Links.link,
                    onWebViewCreated: (InAppWebViewController controler) {
                      _webViewController = controler;
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      android:
                          AndroidInAppWebViewOptions(blockNetworkLoads: true),
                      crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                          supportZoom: false,
                          disableHorizontalScroll: true),
                    ),
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
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
                    onLoadError: (InAppWebViewController controller, String url,
                        int i, String s) async {
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
                            color: WhiteColor,
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Material(
                                elevation: 2,
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  child: Center(
                                    child: FlatButton(
                                      onPressed: () {
                                        _webViewController.reload();
                                        if (showErrorPage) {
                                          hideError();
                                        } else {
                                          showError();
                                        }
                                      },
                                      child: Icon(
                                        Icons.refresh,
                                      ),
                                    ),
                                  ),
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
      bottomNavigationBar:
          MenuNavigationRefresh(webViewController: _webViewController),
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
