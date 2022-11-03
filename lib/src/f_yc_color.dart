import 'dart:math';
import 'package:flutter/widgets.dart';

class FYcColor {
  ///生成随机颜色
  static Color randomColor() {
    return Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }
}
