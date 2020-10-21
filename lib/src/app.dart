import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inoselsweb/src/views/screens/home_screen.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';

class Inoselsweb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      home: WebViewInosels(),
    );
  }
}
