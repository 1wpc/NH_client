import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nh_client/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final chartData = LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: true,
        barWidth: 5,
        isStrokeCapRound: true,
      )
    ],
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    titlesData: const FlTitlesData(
      show: false,
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
  );

  String sayName(String name) {
    return "hi, $name";
  }

  Widget itemCard(String name, double percent) {
    double percentH = percent * 100;
    return SizedBox(
        height: 150,
        width: 250,
        child: Row(
          children: [
            SizedBox(
              width: 200,
              child: Text(name),
            ),
            const SizedBox(
              width: 2,
              height: 250,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  SizedBox(
                    height: 10,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation(Colors.blue),
                      value: percent,
                    ),
                  ),
                  Text("您有 $name 的概率是 $percentH%")
                ],
              ),
            ),
            const Icon(Icons.chevron_right)
          ],
        ));
  }

  Widget dividers() {
    return const Divider(
      height: 0,
      thickness: 2,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(Controller()),
      builder: (controller) {
        return Scaffold(
            body: ListView(
          children: [
            dividers(),
            itemCard("test1", 0.5),
            dividers(),
            itemCard("test2", 0.8),
            dividers()
          ],
        ));
      },
    );
  }
}
