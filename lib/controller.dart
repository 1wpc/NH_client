import 'package:get/get.dart';

class Controller extends GetxController {
  int homeIndex = 0;
  String Data = "";

  void changeIndex(int index) {
    homeIndex = index;
    update();
  }

  void changeData(String s) {
    Data = s;
    update();
  }
}
