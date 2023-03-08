import 'dart:async';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RounteHelper.getInitial()));
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
                width: 400,
                height: 110,
              ),
            ),
          ),
          Center(
            child: Image.asset("assets/image_icon_app/logodown.png",
                width: 365, height: 28),
          ),
        ],
      ),
    );
  }
}
