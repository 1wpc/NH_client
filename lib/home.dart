import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nh_client/home_page.dart';
import 'package:nh_client/mine_page.dart';

import 'controller.dart';

class HomeState extends State<Home> {
  final Controller c = Get.put(Controller());
  final List<BottomNavigationBarItem> bnItems = [
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: "首页"
      ),
      const BottomNavigationBarItem(
        backgroundColor: Color.fromARGB(255, 244, 228, 54),
        icon: Icon(Icons.person),
        label: "我的"
      )
  ];
  final pages = [HomePage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: c,
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            items: bnItems,
            currentIndex: controller.homeIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => controller.changeIndex(value),
          ),
          body: pages[controller.homeIndex],
        );
      },
    );
  }
  
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
  
}