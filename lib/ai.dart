import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_openai/dart_openai.dart';
import 'package:dio/dio.dart';
import 'package:fetch_client/fetch_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nh_client/CLAdapter.dart';
import 'package:nh_client/controller.dart';

class AI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AIState();
  }
}

class _AIState extends State<AI>{
  final c = Get.put(Controller());

  String extractContentValue(String input) {
    // 正则表达式用于匹配 "content": "some value"
    RegExp regExp = RegExp(r""""content"\s*:\s*"([^"]*)"|\'content\'\s*:\s*\'([^\']*)\'""", caseSensitive: false);

    // 使用正则表达式搜索输入字符串
    final matches = regExp.allMatches(input);

    // 如果找到匹配项，则返回匹配的组（即双引号内的字符串）
    return matches.map((match) {
      // 检查第一个捕获组是否有匹配，如果有则返回，否则尝试第二个捕获组
      return match.group(1) ?? match.group(2);
    }).where((value) => value != null) // 过滤掉null值
        .reduce((value, nextValue) => '$value$nextValue') ?? '';
  }

  @override
  void initState(){
    super.initState();
    getResponse(
      """你作为一个心理医生，根据DEAP数据集的情感分类中三个情感轮的概率，
      以及抑郁症的概率，告诉患者的精神状况，以及合理专业的建议。
      {"dp": 0.0, "valence": 0.0, "arousal": 0.0, "dominance": 0.0}每次对话你将会得到这样一个数据格式
      其中dp是抑郁症的概率，valence是愉悦度的概率，arousal是兴奋度的概率，dominance是支配度的概率,抑郁症概率在50%以下是正常的""",
      c.map.toString());
  }

  Future<String> getResponse(String prompt, String userText) async {
    var dataChunks = "";
    try {
      Dio dio = Dio();
      dio.httpClientAdapter = ConversionLayerAdapter(FetchClient(mode: RequestMode.cors));

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
      ],
      'temperature': 0.3,
      'stream': true
    };

  // 发送 POST 请求
    final response = await dio.post<ResponseBody>('https://api.moonshot.cn/v1/chat/completions',
        options: Options(responseType: ResponseType.stream,headers: headers), data: data);

  // 打印响应结果
    // final responseText = response.data['choices'][0]['message']['content'];
    // print(responseText);
    // c.changeDiagnosis(responseText);
    StreamTransformer<Uint8List, List<int>> unit8Transformer =
      StreamTransformer.fromHandlers(
      handleData: (data, sink) {
      sink.add(List<int>.from(data));
      },
    );
      response.data?.stream
          .listen((chunk){
        c.changeDiagnosis(dataChunks+=extractContentValue(utf8.decode(chunk)).replaceAll('\\n', '\n'));
      });


    return "responseText";
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
          appBar: NeumorphicAppBar(
            title: Text("AI诊断"),
            textStyle: TextStyle(
              fontSize: 23
            ),
            leading: IconButton(onPressed: () {
              Get.back();
            }, icon: NeumorphicIcon(
                Icons.arrow_back,
                style: const NeumorphicStyle(
                    depth: 10,
                    color: Colors.black,
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.stadium()
                )
            ),
            )
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Markdown(
              selectable: true,
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(
                    fontSize: 20
                  )
                ),
                data: controller.dignosis
            ),
          // child: ListView(
          //   padding: EdgeInsets.all(16.0),
          //   children: [
          //     NeumorphicText(
          //   controller.dignosis,
          //   style: const NeumorphicStyle(
          //     depth: 5,
          //     color: Colors.black,
          //   ),
          //   textStyle: NeumorphicTextStyle(
          //     fontSize: 24,
          //   ),
          // ),
          //   ]
          // )
      ),
    );
      },
    );
  }

}