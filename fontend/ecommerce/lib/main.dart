import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/directory/Goods/goods_detail_popular.dart';
import 'package:ecommerce/directory/goods/Recommeneded_Goods_Detail.dart';
import 'package:ecommerce/directory/pages/cart/cart_page.dart';
import 'package:ecommerce/directory/pages/splash/splash_page.dart';
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
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home-Pages',
          initialRoute: RounteHelper.getSplashPage(),
          getPages: RounteHelper.routes,
        );
      });
    });
  }
}
