// ignore: file_names
import 'dart:core';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import "package:get/get.dart";

class Dimensions {
  //บางทีก็ติดปัญหาเหมือนกันอาจจะเกี่ยวกับการกำหนดการใช้งานขอบแอพพลิเคชั่นจริงๆ

  //Get.context!.height; = MediaQuery.of(context).size.height.toString()
  //screenHeight = 797.714 of A9
  //screenWidth = 411.4185 of A9
  static var screenHeight = Get.context!.height;
  static var screenWidth = Get.context!.width;

  //Screen
  static double pageViewContainer = screenHeight / 3.70;
  static var textheight = screenHeight * 145 / screenHeight;
}

//คอนเซ็บเทียบบรรยัติไตรยาง เช่น 200 ใน หน้าจอ 816 ถ้าหน้าจอ 1000 จะได้ค่า x เท่าไหร่
// ignore: non_constant_identifier_names
Widget DimensionwidthWidget(BuildContext context, var widthunitpixel) {
  var widthbox = MediaQuery.of(context).size.width;
  return SizedBox(
    width: widthbox * widthunitpixel / 411.4185,
  );
}

// ignore: non_constant_identifier_names
Widget DimensionheightWidget(BuildContext context, var heightunitpixel) {
  var heightbox = MediaQuery.of(context).size.height;
  return SizedBox(
    height: heightbox * heightunitpixel / 797.714,
  );
}

// ignore: non_constant_identifier_names
DimensionStaticWidth(BuildContext context, var widthinput) {
  var widthbox = MediaQuery.of(context).size.width;
  var widthcustom = widthbox * widthinput / 411.4185;
  return widthcustom;
}

// ignore: non_constant_identifier_names
DimensionStaticHeight(BuildContext context, var heightinput) {
  var heightbox = MediaQuery.of(context).size.height;
  var heightcustom = heightbox * heightinput / 797.714;
  return heightcustom;
}
