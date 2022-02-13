import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/controller.dart';
import 'splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GeneralController());

    return GetMaterialApp(
      title: 'DoughyGoodness Home Bakery',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.barlowTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Splash(),
    );
  }
}
