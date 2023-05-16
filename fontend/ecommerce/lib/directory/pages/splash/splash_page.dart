import 'dart:async';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final String token;
  const SplashScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String _token;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  /* ใช้เท่านี้ก็ไม่ต้อง GetBuilder ที่ main.dart แต่เพื่อความชัว
  _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }*/

  @override
  void initState() {
    super.initState();
    _loadResource();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _token = widget.token;
    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RounteHelper.getInitial(_token)));
    print("token : $_token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            axisAlignment: -1,
            child: Center(
              child: Image.asset(
                "assets/image_icon_app/logoup.png",
                width: DimensionStaticWidth(context, 400),
                height: DimensionStaticHeight(context, 120),
              ),
            ),
          ),
          Center(
            child: Image.asset("assets/image_icon_app/logodown.png",
                width: DimensionStaticWidth(context, 365),
                height: DimensionStaticHeight(context, 28)),
          ),
        ],
      ),
    );
  }
}
