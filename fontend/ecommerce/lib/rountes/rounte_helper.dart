import 'package:ecommerce/directory/goods/Recommeneded_Goods_Detail.dart';
import 'package:ecommerce/directory/goods/goods_detail_popular.dart';
import 'package:ecommerce/directory/goods/home_page.dart';
import 'package:ecommerce/directory/pages/cart/cart_page.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:ecommerce/directory/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RounteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularGoods = "/popular-goods";
  static const String recommendedGoods = "/recommended-goods";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularGoods(int pageId, String page) =>
      '$popularGoods?pageId=$pageId&page=$page';
  static String getRecommededGoods(int pageId, String page) =>
      '$recommendedGoods?pageId=$pageId&page=$page';
  static String getCartPage() => "$cartPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularGoods,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularGoodsDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedGoods,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommenededGoodsDetail(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
  ];
}
