import 'package:get/get.dart';

class Controller extends GetxController {
  int homeIndex = 0;
  Map map = {"dp": 0.0, "valence": 0.0, "arousal": 0.0, "dominance": 0.0};
  void changeIndex(int index) {
    homeIndex = index;
    update();
  }

  void changeMap(Map m) {
    map = m;
    update();
  }
}
