import 'package:ecommerce/directory/Goods/goods_detail_popular.dart';
import 'package:ecommerce/directory/goods/Recommeneded_Goods_Detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'directory/pages/main_goods_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home-Pages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //scaffoldBackgroundColor: Colors.white,
      ),
      //home: const MainGoodPage(),
      //home: const PopularGoodsDetail(),
      home: const RecommenededGoodsDetail(),
    );
  }
}
