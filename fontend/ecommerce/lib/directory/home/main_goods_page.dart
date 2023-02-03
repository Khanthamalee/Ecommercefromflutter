import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/directory/home/goods_pagebody.dart';

class MainGoodPage extends StatefulWidget {
  const MainGoodPage({super.key});

  @override
  State<MainGoodPage> createState() => _MainGoodPageState();
}

class _MainGoodPageState extends State<MainGoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //header
          Container(
            margin: const EdgeInsets.only(top: 45, bottom: 15),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Tornado550243",
                      color: AppColors.mainColor,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SmallText(
                          text: "Thailand-Chaiyaphum",
                          color: Colors.black,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          //body
          const GoodsPageBody(),
        ],
      ),
    );
  }
}
