// ignore: file_names
import 'dart:core';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import "package:get/get.dart";

class Dimensions {
  //Get.context!.height; = MediaQuery.of(context).size.height.toString()
  //screenHeight = 816
  //screenWidth = 432
  static var screenHeight = Get.context!.height;
  static var screenWidth = Get.context!.width;

  //Screen
  static double pageViewContainer = screenHeight / 3.70;
  static var textheight = screenHeight * 145 / screenHeight;
}

// ignore: non_constant_identifier_names
Widget DimensionwidthWidget(BuildContext context, var widthunitpixel) {
  var widthbox = MediaQuery.of(context).size.width;
  return SizedBox(
    width: widthbox * widthunitpixel / 432,
  );
}

// ignore: non_constant_identifier_names
Widget DimensionheightWidget(BuildContext context, var heightunitpixel) {
  var heightbox = MediaQuery.of(context).size.height;
  return SizedBox(
    height: heightbox * heightunitpixel / 816,
  );
}

// ignore: non_constant_identifier_names
DimensionStaticWidth(BuildContext context, var widthinput) {
  var widthbox = MediaQuery.of(context).size.width;
  var widthcustom = widthbox * widthinput / 432;
  return widthcustom;
}

// ignore: non_constant_identifier_names
DimensionStaticHeight(BuildContext context, var heightinput) {
  var heightbox = MediaQuery.of(context).size.height;
  var heightcustom = heightbox * heightinput / 816;
  return heightcustom;
}
