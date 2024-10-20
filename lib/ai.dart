import 'package:dart_openai/dart_openai.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nh_client/controller.dart';

class AI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AIState();
  }
}

class _AIState extends State<AI>{
  final c = Get.put(Controller());

  @override
  void initState(){
    super.initState();
    //c.changeDiagnosis("AI心理医生正在生成您的专属诊断报告，请稍后...");
    getResponse(
      """你作为一个心理医生，根据DEAP数据集的情感分类中三个情感轮的概率，
      以及抑郁症的概率，告诉患者的精神状况，以及合理专业的建议。
      {"dp": 0.0, "valence": 0.0, "arousal": 0.0, "dominance": 0.0}每次对话你将会得到这样一个数据格式
      其中dp是抑郁症的概率，valence是愉悦度的概率，arousal是兴奋度的概率，dominance是支配度的概率""", 
      c.map.toString());
  }

  Future<String> getResponse(String prompt, String userText) async {
    try {
      Dio dio = Dio();

  // 设置请求头
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer sk-68BjgN9UrzofPiunPduYMLLgUec6mpMppGOvfAtSJPVd5YMe',
    };

  // 设置请求参数
    Map<String, dynamic> data = {
      'model': 'moonshot-v1-8k',
      'messages': [
        {'role': 'system', 'content': prompt},
        {'role': 'user', 'content': userText}
      ]
    };

  // 发送 POST 请求
    final response = await dio.post('https://api.moonshot.cn/v1/chat/completions',
        options: Options(headers: headers), data: data);

  // 打印响应结果
    final responseText = response.data['choices'][0]['message']['content'];
    print(responseText);
    c.changeDiagnosis(responseText);

    return responseText;
  } on RequestFailedException catch (e) {
    // 错误处理
    return "Error: ${e.message}";
  } catch (e) {
    // 其他错误处理
    return "Error: $e";
  }
}

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: c,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              NeumorphicText(
            controller.dignosis,
            style: const NeumorphicStyle(
              depth: 5,
              color: Colors.black,
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 24,
            ),
          ),
            ]
          )
      ),
    );
      },
    );
  }

}