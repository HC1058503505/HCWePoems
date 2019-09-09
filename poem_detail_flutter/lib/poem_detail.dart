import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:ui';

class PoemDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PoemDetailState();
  }
}

const pushMainPlatform = const MethodChannel('houocng.flutter.io/poemd_detail');

class _PoemDetailState extends State<PoemDetail> {
  Map<String, String> poemCommend = {
    "poemId": "",
    "poemTitle": "",
    "poemCont": "",
    "author": "",
    "dynasty": "",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Native调用原生监听
  Future<dynamic> handelPushCall(MethodCall methodCall) {
    String backResult = "failure";
    if (methodCall.method == "getPoemRecommend") {
      poemCommend = Map.from(methodCall.arguments);
      backResult = "success";
      setState(() {});
    }
    return Future.value(backResult);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    pushMainPlatform.setMethodCallHandler(handelPushCall);

    return MaterialApp(
      home: Container(
        padding: EdgeInsets.fromLTRB(10, window.viewPadding.top, 10, 0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Text(
              poemCommend["poemTitle"],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontSize: 25.0,
              ),
            ),
            Text(
              poemCommend["author"] + "/" + poemCommend["dynasty"],
              style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Html(
                customTextAlign: (node) {
                  return TextAlign.center;
                },
                useRichText: true,
                data: poemCommend["poemCont"],
                defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
      routes: <String, WidgetBuilder>{
        "poemDetail": (BuildContext context) => PoemDetail()
      },
    );
  }
}
