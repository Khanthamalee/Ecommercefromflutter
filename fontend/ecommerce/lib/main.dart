import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/directory/pages/resetpassword/resetpassword_page.dart';
import 'package:ecommerce/directory/pages/sign_in/sign_in.dart';
import 'package:ecommerce/directory/pages/sign_up/authenticate_email.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_page.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          //home: ResetPasswordPage(),
          //home: SignUpPage(),
          //home: AuthEmail(),
          //home: SignInPage(),

          initialRoute: RounteHelper.getSignInPage(),
          getPages: RounteHelper.routes,
        );
      });
    });
  }
}
