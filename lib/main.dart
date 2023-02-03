import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/marge_screens/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      initialRoute: '/',
      theme: ThemeData(
          primaryColor: Color(0xFF009247),
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.transparent, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF009247))
      ),

    );

  }

}


