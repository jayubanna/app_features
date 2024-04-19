import 'package:app_features/splash_page.dart';
import 'package:app_features/updet.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'home_page.dart';

void main()
{
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "home_page":(context) => Home(),
        "detail_page":(context) => Detailpage(),
      },
    );
  }
}