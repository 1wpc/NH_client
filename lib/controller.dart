import 'package:get/get.dart';

class Controller extends GetxController{
  int homeIndex = 0;

  void changeIndex(int index) {
    homeIndex = index;
    update();
  }
}