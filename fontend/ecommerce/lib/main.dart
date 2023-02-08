import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/directory/Goods/goods_detail_popular.dart';
import 'package:ecommerce/directory/goods/Recommeneded_Goods_Detail.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'directory/pages/main_goods_page.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    // ignore: prefer_const_constructors
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home-Pages',
      home: const MainGoodPage(),
      initialRoute: RounteHelper.initial,
      getPages: RounteHelper.routes,
      //home: const PopularGoodsDetail(),
      //home: const RecommenededGoodsDetail(),
    );
  }
}
