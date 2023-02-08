import 'package:ecommerce/directory/goods/Recommeneded_Goods_Detail.dart';
import 'package:ecommerce/directory/goods/goods_detail_popular.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:get/get.dart';

class RounteHelper {
  static const String initial = "/";
  static const String popularGoods = "/popular-goods";
  static const String recommendedGoods = "/recommended-goods";

  static String getInitial() => '$initial';
  static String getPopularGoods(int pageId) => '$popularGoods?pageId=$pageId';
  static String getRecommededGoods(int pageId) =>
      '$recommendedGoods?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          return const MainGoodPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularGoods,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularGoodsDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedGoods,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommenededGoodsDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
