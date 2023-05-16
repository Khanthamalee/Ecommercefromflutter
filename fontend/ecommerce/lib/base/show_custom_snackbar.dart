import 'package:ecommerce/widget/bigtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, Color backgroundColor,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(text: title, color: Colors.white),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
  );
}
