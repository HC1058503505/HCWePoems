import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

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

  void getPoemRecommend(
      {String poemId,
      String poemTitle,
      String poemCont,
      String author,
      String dynasty}) {
    setState(() {
      poemCommend = {
        "poemId": poemId,
        "poemTitle": poemTitle,
        "poemCont": poemCont,
        "author": author,
        "dynasty": dynasty,
      };
    });
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
        padding: EdgeInsets.fromLTRB(10, 64, 10, 0),
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
            Text(
              poemCommend["poemCont"],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontSize: 18.0,
              ),
            ),
            Html(
              customTextAlign: (node) {
                return TextAlign.center;
              },
              useRichText: true,
              data: poemCommend["poemCont"],
              defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
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
