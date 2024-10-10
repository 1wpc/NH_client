import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nh_client/controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
  
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(Controller()),
      builder: (controller) {
        return Text('main page is not done yet');
      },
    );
  }
}