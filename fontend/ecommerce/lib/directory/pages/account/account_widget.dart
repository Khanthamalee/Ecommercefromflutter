import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final Color iconColor;
  final Color bgiconColor;
  final String text;
  final IconData icon;
  final double height;
  final int maxlines;

  const AccountWidget(
      {Key? key,
      required this.text,
      required this.iconColor,
      required this.bgiconColor,
      required this.icon,
      this.height = 0,
      this.maxlines = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: height == 0 ? DimensionStaticHeight(context, 60) : height,
        width: DimensionStaticWidth(context, 400),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFDFDFDF)),
            left: BorderSide(color: Color(0xFFDFDFDF)),
          ),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIcon(
              icon: icon,
              iconColor: iconColor,
              backgroundColor: bgiconColor,
              size: 30,
            ),
            DimensionwidthWidget(context, 30),
            SizedBox(
              child: Container(
                width: 260,
                child: BigText(
                  text: text,
                  maxlines: maxlines == 0 ? 1 : maxlines,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
