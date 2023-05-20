import 'package:ecommerce/base/no_data_cartpage.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/location_controller.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final int pageId;
  final String page;
  final String token;
  const CartPage(
      {Key? key, required this.pageId, required this.page, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("token in CartPage: ${token}");
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: DimensionStaticHeight(context, 20 * 3),
                left: DimensionStaticWidth(context, 20),
                right: DimensionStaticWidth(context, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<CartController>(builder: (CartController) {
                      var _CartList = CartController.getItems;
                      return GestureDetector(
                        onTap: () {
                          //var id = pageId;
                          if (pageId == pageId &&
                              page == "reccommendedcartpage") {
                            var popularIndex =
                                Get.find<PopularProductController>()
                                    .popularProductList
                                    .indexOf(_CartList[pageId].product);
                            Get.toNamed(RounteHelper.getRecommededGoods(
                                pageId, "reccommendedcartpage", token));
                          } else if (pageId == pageId &&
                              page == "popularcartpage") {
                            Get.toNamed(RounteHelper.getPopularGoods(
                                pageId, "popularcartpage", token));
                          } else {
                            Get.toNamed(RounteHelper.getInitial(token));
                          }
                          print("pageId : $pageId");
                          print("page : $page");
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back_ios,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconsize: DimensionStaticHeight(context, 24),
                        ),
                      );
                    }),
                    DimensionwidthWidget(context, 20 * 5),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RounteHelper.getInitial(token));
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconsize: DimensionStaticHeight(context, 24),
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconsize: DimensionStaticHeight(context, 24),
                    ),
                  ],
                )),
            GetBuilder<CartController>(
              builder: (_cartController) {
                return _cartController.getItems.isNotEmpty
                    ? Positioned(
                        top: DimensionStaticHeight(context, 20 * 6),
                        left: DimensionStaticWidth(context, 20),
                        right: DimensionStaticWidth(context, 20),
                        bottom: 0,
                        child: Container(
                          //color: Colors.red,
                          child: Container(
                              //color: Colors.red,
                              child: MediaQuery.removeViewPadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (CartController) {
                              var _CartList = CartController.getItems;
                              //print("_CartList.length : ${_CartList.length}");
                              //print(
                              //"id : ${_CartList[1].id} name : ${_CartList[1].name}  ");

                              return ListView.builder(
                                itemCount: _CartList.length,
                                itemBuilder: (_, index) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(index);
                                          /*var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_CartList[index].product);*/

                                          if (Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .contains(
                                                  _CartList[index].product)) {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _CartList[index].product);
                                            print(
                                                "popularIndex : ${popularIndex}");
                                            Get.toNamed(
                                                RounteHelper.getPopularGoods(
                                                    popularIndex,
                                                    "cartpage",
                                                    token));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    _CartList[index].product);
                                            print(
                                                "recommendedIndex : ${recommendedIndex}");
                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                "รายการสั่งซื้อสิ้นค้า",
                                                "ไม่สามารถเข้าถึงรายละเอียดสินค้าได้ค่ะ",
                                                backgroundColor:
                                                    Colors.redAccent,
                                                colorText: Colors.white,
                                                duration: Duration(seconds: 1),
                                              );
                                            } else {
                                              Get.toNamed(RounteHelper
                                                  .getRecommededGoods(
                                                      recommendedIndex,
                                                      "cartpage",
                                                      token));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: DimensionStaticWidth(
                                              context, 20 * 5),
                                          height: DimensionStaticHeight(
                                              context, 20 * 5),
                                          margin: EdgeInsets.only(
                                              bottom: DimensionStaticHeight(
                                                  context, 10)),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    _CartList[index].img!),
                                                /*image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              _CartList[index].img!)*/
                                                // AssetImage("assets/image_ui/corn.png")
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      DimensionStaticHeight(
                                                          context, 20))),
                                        ),
                                      ),
                                      DimensionwidthWidget(context, 10),
                                      Expanded(
                                        child: Container(
                                          height: DimensionStaticHeight(
                                              context, 20 * 5),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text:
                                                      "${_CartList[index].name!}",
                                                  color: Colors.black45,
                                                ),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text:
                                                          "฿ ${_CartList[index].price! * _CartList[index].quantity!}",
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              DimensionStaticHeight(
                                                                  context, 8)),
                                                      padding: EdgeInsets.only(
                                                          top:
                                                              DimensionStaticHeight(
                                                                  context, 8),
                                                          bottom:
                                                              DimensionStaticHeight(
                                                                  context, 8),
                                                          left:
                                                              DimensionStaticWidth(
                                                                  context, 8),
                                                          right:
                                                              DimensionStaticWidth(
                                                                  context, 8)),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  DimensionStaticHeight(
                                                                      context,
                                                                      15)),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              CartController.addItems(
                                                                  _CartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                          DimensionwidthWidget(
                                                              context, 10),
                                                          BigText(
                                                              text:
                                                                  "${_CartList[index].quantity!}"),
                                                          DimensionwidthWidget(
                                                              context, 10),
                                                          GestureDetector(
                                                              onTap: () {
                                                                CartController.addItems(
                                                                    _CartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                        ),
                                      )
                                    ],
                                  );
                                  /*  return Container(
                        height: DimensionStaticHeight(context, 100),
                        width: DimensionStaticWidth(context, 200),
                        color: Colors.blue,
                        margin: EdgeInsets.only(
                            bottom: DimensionStaticHeight(context, 10)),
                      );*/
                                },
                              );
                            }),
                          )),
                        ))
                    : const NoDataPage(
                        text: "ไม่มีรายการสินค้าของคุณ",
                      );
              },
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartcontroller) {
          return Container(
            height: DimensionStaticHeight(context, 100),
            padding: EdgeInsets.only(
                top: DimensionStaticHeight(context, 10),
                bottom: DimensionStaticHeight(context, 20)),
            decoration: BoxDecoration(
              color: AppColors.buttonbackgroungColor,
              borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(DimensionStaticHeight(context, 20 * 2)),
                topRight:
                    Radius.circular(DimensionStaticHeight(context, 20 * 2)),
              ),
            ),
            child: cartcontroller.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: DimensionStaticHeight(context, 20),
                                bottom: DimensionStaticHeight(context, 20),
                                left: DimensionStaticWidth(context, 20),
                                right: DimensionStaticWidth(context, 10)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  DimensionStaticHeight(context, 20)),
                            ),
                            child: Row(
                              children: [
                                DimensionwidthWidget(context, 10),
                                BigText(
                                  text: "ราคารวม",
                                  size: 20,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: DimensionStaticHeight(context, 20),
                                bottom: DimensionStaticHeight(context, 20),
                                left: DimensionStaticWidth(context, 20),
                                right: DimensionStaticWidth(context, 20)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  DimensionStaticHeight(context, 20),
                                ),
                                color: Colors.white),
                            child: BigText(
                                text:
                                    "฿ ${cartcontroller.totalAmount.toString()}"),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            if (Get.find<LocationController>()
                                .addressList
                                .isEmpty) {
                              print("tap");
                              Get.back();
                              Get.toNamed(RounteHelper.getAddAddressPage());
                            } else {
                              cartcontroller.addToHistory();
                            }
                          } else {
                            Get.toNamed(RounteHelper.getSignInPage());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: DimensionStaticHeight(context, 20)),
                          padding: EdgeInsets.only(
                              top: DimensionStaticHeight(context, 20),
                              bottom: DimensionStaticHeight(context, 20),
                              left: DimensionStaticWidth(context, 20),
                              right: DimensionStaticWidth(context, 20)),

                          // ignore: sort_child_properties_last
                          child: BigText(
                            text: "สั่งซื้อ",
                            color: Colors.white,
                          ),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  DimensionStaticHeight(context, 20)),
                              color: AppColors.mainColor),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        }));
  }
}
