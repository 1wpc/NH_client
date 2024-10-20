import 'package:get/get.dart';

class Controller extends GetxController {
  int homeIndex = 0;
  Map map = {"dp": 0.34, "valence": 0.21, "arousal": 0.45, "dominance": 0.78};
  String dignosis = "";

  void changeIndex(int index) {
    homeIndex = index;
    update();
  }

  void changeMap(Map m) {
    map = m;
    update();
  }

  void changeDiagnosis(String d) {
    dignosis = d;
    update();
  }

}
