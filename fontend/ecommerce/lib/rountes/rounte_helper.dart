import 'package:ecommerce/directory/goods/Recommeneded_Goods_Detail.dart';
import 'package:ecommerce/directory/goods/goods_detail_popular.dart';
import 'package:ecommerce/directory/goods/home_page.dart';
import 'package:ecommerce/directory/pages/address/add_address_page.dart';
import 'package:ecommerce/directory/pages/cart/cart_history.dart';
import 'package:ecommerce/directory/pages/cart/cart_page.dart';
import 'package:ecommerce/directory/pages/goods_pagebody.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:ecommerce/directory/pages/resetpassword/changepassword_page.dart';
import 'package:ecommerce/directory/pages/resetpassword/resetpassword_page.dart';
import 'package:ecommerce/directory/pages/sign_in/sign_in.dart';
import 'package:ecommerce/directory/pages/sign_up/authenticate_email.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_page.dart';
import 'package:ecommerce/directory/pages/splash/splash_page.dart';
import 'package:ecommerce/widget/WidgetRecommended.dart';
import 'package:get/get.dart';

class RounteHelper {
  static const String splashPage = "/splash-page";
  static const String signInPage = "/signin-page";
  static const String authEmail = "/authEmail-page";
  static const String signUpPage = "/signup-page";
  static const String resetPasswordPage = "/resetPasswordPage-page";
  static const String changePasswordPage = "/changePasswordPage-page";
  static const String initial = "/";
  static const String popularGoods = "/popular-goods";
  static const String mainGoodPage = "/mainGoodPage-goods";
  static const String goodsPageBody = "/goodsPageBody-pages";
  static const String recommendedGoods = "/recommended-goods";
  static const String myWidgetReccommended = "/myWidgetReccommended";
  static const String cartPage = "/cart-page";
  static const String cartHistory = "/cartHistory-page";
  static const String addAddressPage = "/addAddress-Page";

  static String getSplashPage(String token) => '$splashPage?token=$token';

  static String getSignInPage() => '$signInPage';

  static String getAuthEmail() => '$authEmail';

  static String getSignUpPage() => '$signUpPage';

  static String getResetPasswordPage() => '$resetPasswordPage';

  static String getchangePassword() => '$changePasswordPage';

  static String getInitial(String token) => '$initial?token=$token';

  static String getMainGoodPage(String token) => "$mainGoodPage?token=$token";

  static String getGoodsPageBody(String token) => "$goodsPageBody?token=$token";

  static String getPopularGoods(int pageId, String page, String token) =>
      '$popularGoods?pageId=$pageId&page=$page&token=$token';

  static String getRecommededGoods(int pageId, String page, String token) =>
      '$recommendedGoods?pageId=$pageId&page=$page&token=$token';

  static String getMyWidgetReccommended(String token) =>
      '$recommendedGoods?token=$token';

  static String getCartPage(int pageId, String page, String token) =>
      "$cartPage?pageId=$pageId&page=$page&token=$token";

  static String getCartHistory(String token) => "$cartHistory?token=$token";

  static String getAddAddressPage() => '$addAddressPage';

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () {
          var token = Get.parameters['token'];
          return SplashScreen(token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addAddressPage,
        page: () => const AddAddressPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: signInPage,
        page: () => const SignInPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: authEmail,
        page: () => const AuthEmail(),
        transition: Transition.fadeIn),
    GetPage(
        name: signUpPage,
        page: () {
          var emailotp = Get.parameters['emailotp'];
          return SignUpPage(emailotp: emailotp!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: resetPasswordPage,
        page: () => const ResetPasswordPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: changePasswordPage,
        page: () => const ChangePasswordPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: initial,
        page: () {
          var token = Get.parameters['token'];
          return HomePage(token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: mainGoodPage,
        page: () {
          var token = Get.parameters['token'];
          return MainGoodPage(token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: goodsPageBody,
        page: () {
          var token = Get.parameters['token'];
          return GoodsPageBody(token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularGoods,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          var token = Get.parameters['token'];
          return PopularGoodsDetail(
              pageId: int.parse(pageId!), page: page!, token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedGoods,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          var token = Get.parameters['token'];
          return RecommenededGoodsDetail(
              pageId: int.parse(pageId!), page: page!, token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: myWidgetReccommended,
        page: () {
          var token = Get.parameters['token'];
          return MyWidgetReccommended(token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          var token = Get.parameters['token'];
          return CartPage(
              pageId: int.parse(pageId!), page: page!, token: token!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartHistory,
        page: () {
          var token = Get.parameters['token'];
          return CartHistory(token: token!);
        },
        transition: Transition.fadeIn),
  ];
}
