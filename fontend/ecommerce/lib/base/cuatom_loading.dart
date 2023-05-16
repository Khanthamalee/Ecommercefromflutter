import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    print(
        "I am printing loading state ${Get.find<AuthController>().isLoading}");
    return Center(
      child: Container(
        height: DimensionStaticHeight(context, 20 * 5),
        width: DimensionStaticWidth(context, 20 * 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                DimensionStaticHeight(context, 20 * 5 / 2)),
            color: AppColors.mainColor),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
