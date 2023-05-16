import 'package:ecommerce/widget/WidgetRecommended.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/directory/pages/goods_pagebody.dart';
import '../../util/dimensionWidget.dart';

class MainGoodPage extends StatefulWidget {
  final String token;
  const MainGoodPage({Key? key, required this.token}) : super(key: key);

  @override
  State<MainGoodPage> createState() => _MainGoodPageState();
}

class _MainGoodPageState extends State<MainGoodPage> {
  late String _token;

  void initState() {
    _token = widget.token;
    print("token in MainGoodPage : $_token");
  }

  @override
  Widget build(BuildContext context) {
    // print("current height is " + MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          //Slide section
          //header
          Container(
            margin: EdgeInsets.only(
                top: DimensionStaticHeight(context, 45),
                bottom: DimensionStaticHeight(context, 15)),
            padding: EdgeInsets.only(
                left: DimensionStaticWidth(context, 20),
                right: DimensionStaticWidth(context, 20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Thailand",
                      color: AppColors.mainColor,
                    ),
                    DimensionheightWidget(context, 5),
                    Row(
                      children: [
                        SmallText(
                          text: "   Chaiyaphum",
                          color: Colors.black,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: DimensionStaticWidth(context, 45),
                    height: DimensionStaticHeight(context, 45),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          DimensionStaticHeight(context, 15)),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: DimensionStaticHeight(context, 24),
                    ),
                  ),
                )
              ],
            ),
          ),
          //body
          Expanded(
              child: SingleChildScrollView(
            child: GoodsPageBody(token: _token),
          )),
        ],
      ),
    );
  }
}
