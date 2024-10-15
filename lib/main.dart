import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nh_client/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return NeumorphicApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Neumorphic App',
    //   themeMode: ThemeMode.light,
    //   theme: NeumorphicThemeData(
    //     baseColor: Color(0xFFFFFFFF),
    //     lightSource: LightSource.topLeft,
    //     depth: 10,
    //   ),
    //   darkTheme: NeumorphicThemeData(
    //     baseColor: Color(0xFF3E3E3E),
    //     lightSource: LightSource.topLeft,
    //     depth: 6,
    //   ),
    //   home: Home(),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
