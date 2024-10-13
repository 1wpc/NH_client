import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Content extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ContentState();
  }
}

class _ContentState extends State<Content>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Content'),
      )
    );
  }
}