import 'package:flutter/material.dart';
import 'package:poem_detail_flutter/poem_detail.dart';
import 'dart:ui';

void main() => runApp(routePage(window.defaultRouteName));

Widget routePage(String routeName) {
  switch (routeName) {
    case "poemDetail":
      return PoemDetail();
    default:
      return PoemDetail();
  }
}
