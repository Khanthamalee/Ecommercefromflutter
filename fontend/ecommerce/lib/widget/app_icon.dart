import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconsize;

  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xFFf7f6f4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 0,
      this.iconsize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size == 0 ? DimensionStaticHeight(context, 40) : size,
      height: size == 0 ? DimensionStaticHeight(context, 40) : size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            size == 0 ? DimensionStaticHeight(context, 40) : size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconsize == 0 ? DimensionStaticHeight(context, 16) : iconsize,
      ),
    );
  }
}
