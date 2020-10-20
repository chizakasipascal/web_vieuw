import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:inoselsweb/src/data/network/link.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: Links.link,
      withJavascript: true,
      withZoom: false,
      hidden: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Inosels"),
      ),
      initialChild: Center(child: CircularProgressIndicator()),
    );
  }
}
