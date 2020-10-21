import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inoselsweb/utils/colors.dart';

class MenuNavigationRefresh extends StatelessWidget {
  const MenuNavigationRefresh({
    Key key,
    @required InAppWebViewController webViewController,
  })  : _webViewController = webViewController,
        super(key: key);

  final InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FlatButton(
          child: Icon(
            Icons.arrow_back,
            color: WhiteColor,
          ),
          onPressed: () {
            if (_webViewController != null) {
              _webViewController.goBack();
            }
          },
        ),
        FlatButton(
          child: Icon(
            Icons.arrow_forward,
            color: WhiteColor,
          ),
          onPressed: () {
            if (_webViewController != null) {
              _webViewController.goForward();
            }
          },
        ),
        FlatButton(
          child: Icon(
            Icons.refresh,
            color: WhiteColor,
          ),
          onPressed: () {
            if (_webViewController != null) {
              _webViewController.reload();
            }
          },
        ),
      ],
    );
  }
}
