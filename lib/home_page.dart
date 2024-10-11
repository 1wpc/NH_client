import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nh_client/controller.dart';

class HomePage extends StatefulWidget {
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
    titlesData: FlTitlesData(
        show: false,
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
  );

  Widget itemCard() {
    return Container(
            width: 250,
            height: 250,
            child: Neumorphic(
              textStyle: TextStyle(
                fontSize: 25
              ),
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)), 
                depth: 8,
                lightSource: LightSource.topLeft,
                color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: 
                  LineChart(
                    chartData,
                    duration: Duration(milliseconds: 150),
                  ),
            )
          );
  }
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(Controller()),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              itemCard(),
              itemCard()
            ],
          )
        );
      },
    );
  }
}