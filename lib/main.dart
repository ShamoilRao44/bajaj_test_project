// ignore_for_file: prefer_const_constructors

import 'package:bajaj_test_project/bindings.dart';
import 'package:bajaj_test_project/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '0827CI211163',
      debugShowCheckedModeBanner: false,
      initialRoute: '/HomeView',
      getPages: [
        GetPage(
          name: '/HomeView',
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
