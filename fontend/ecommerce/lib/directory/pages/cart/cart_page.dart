import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconsize: DimensionStaticHeight(context, 24),
                ),
                DimensionwidthWidget(context, 20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RounteHelper.getInitial());
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
        Positioned(
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
                child: GetBuilder<CartController>(builder: (CartController) {
                  var _CartList = CartController.getItems;
                  print("_CartList.length : ${_CartList.length}");

                  return ListView.builder(
                    itemCount: _CartList.length,
                    itemBuilder: (_, index) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              var popularIndex =
                                  Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(_CartList[index].product!);
                              if (popularIndex >= 0) {
                                Get.toNamed(RounteHelper.getPopularGoods(
                                    popularIndex, "cartpage"));
                              } else {
                                var recommendedIndex =
                                    Get.find<RecommendedProductController>()
                                        .recommendedProductList
                                        .indexOf(_CartList[index].product!);
                                Get.toNamed(RounteHelper.getRecommededGoods(
                                    recommendedIndex, "cartpage"));
                              }
                            },
                            child: Container(
                              width: DimensionStaticWidth(context, 20 * 5),
                              height: DimensionStaticHeight(context, 20 * 5),
                              margin: EdgeInsets.only(
                                  bottom: DimensionStaticHeight(context, 10)),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(_CartList[index].img!),
                                    /*image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              _CartList[index].img!)*/
                                    // AssetImage("assets/image_ui/corn.png")
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      DimensionStaticHeight(context, 20))),
                            ),
                          ),
                          DimensionwidthWidget(context, 10),
                          Expanded(
                            child: Container(
                              height: DimensionStaticHeight(context, 20 * 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text: "${_CartList[index].name!}",
                                      color: Colors.black45,
                                    ),
                                    SmallText(text: "Spicy"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text:
                                              "\$ ${_CartList[index].price! * _CartList[index].quantity!}",
                                          color: Colors.redAccent,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: DimensionStaticHeight(
                                                  context, 8)),
                                          padding: EdgeInsets.only(
                                              top: DimensionStaticHeight(
                                                  context, 8),
                                              bottom: DimensionStaticHeight(
                                                  context, 8),
                                              left: DimensionStaticWidth(
                                                  context, 8),
                                              right: DimensionStaticWidth(
                                                  context, 8)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      DimensionStaticHeight(
                                                          context, 15)),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  CartController.addItems(
                                                      _CartList[index].product!,
                                                      -1);
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: AppColors.signColor,
                                                ),
                                              ),
                                              DimensionwidthWidget(context, 10),
                                              BigText(
                                                  text:
                                                      "${_CartList[index].quantity!}"),
                                              DimensionwidthWidget(context, 10),
                                              GestureDetector(
                                                  onTap: () {
                                                    CartController.addItems(
                                                        _CartList[index]
                                                            .product!,
                                                        1);
                                                  },
                                                  child: Icon(Icons.add,
                                                      color:
                                                          AppColors.signColor))
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
            )),
      ],
    ));
  }
}
