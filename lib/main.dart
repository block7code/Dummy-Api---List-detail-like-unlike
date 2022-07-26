import 'dart:io';

import 'package:dummy_api/core/router/router.dart';
import 'package:dummy_api/views/screens/navigator.dart';
import 'package:dummy_api/views/styles/b7c_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      theme: B7CTheme.mainTheme,
      home: const NavigatorDashoard(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
