import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screen/homepage.dart';
import 'package:myapp/screen/horoscope_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // เปลี่ยนจาก MaterialApp เป็น GetMaterialApp
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/horoscope', page: () => HoroscopeScreen()),
        //GetPage(name: '/tarot', page: () => TarotScreen()),
      ],
    );
  }
}
