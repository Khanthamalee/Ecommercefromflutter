import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/directory/pages/cart/cart_page.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:ecommerce/widget/widget_detail_underimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

//Detail ListView.builder from WidgetPopular

class RecommenededGoodsDetail extends StatelessWidget {
  final int pageId;
  const RecommenededGoodsDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    //print("page is id $pageId ");
    print("Recommended product name is ${product.name}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        //Big image

        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(RounteHelper.getInitial());
                },
                child: const AppIcon(icon: Icons.clear)),
            //const AppIcon(icon: Icons.shopping_cart_outlined)
            GetBuilder<PopularProductController>(builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (controller.totalItems >= 1)
                    Get.toNamed(RounteHelper.getCartPage());
                },
                child: Stack(
                  children: [
                    AppIcon(icon: Icons.shopping_cart_outlined),
                    Get.find<PopularProductController>().totalItems >= 1
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ),
                          )
                        : Container(),
                    Get.find<PopularProductController>().totalItems >= 1 &&
                            Get.find<PopularProductController>().totalItems <= 9
                        ? Positioned(
                            top: DimensionStaticHeight(context, 4),
                            right: DimensionStaticWidth(context, 7),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Get.find<PopularProductController>().totalItems > 9
                            ? Positioned(
                                top: DimensionStaticHeight(context, 4),
                                right: DimensionStaticWidth(context, 4),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                  ],
                ),
              );
            })
          ]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(DimensionStaticHeight(context, 40)),
            child: Container(
              // ignore: sort_child_properties_last
              child: Center(
                child: BigText(
                  text: product.name,
                  size: DimensionStaticHeight(context, 26),
                ),
              ),
              width: double.maxFinite,
              padding: EdgeInsets.only(
                  top: DimensionStaticHeight(context, 5),
                  bottom: DimensionStaticHeight(context, 10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(DimensionStaticHeight(context, 20)),
                      topRight:
                          Radius.circular(DimensionStaticHeight(context, 20)))),
            ),
          ),
          pinned: true,
          backgroundColor: AppColors.yellowColor,
          expandedHeight: DimensionStaticHeight(context, 300),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
              height: DimensionStaticHeight(context, 800),
              child: Column(
                children: [
                  Container(
                    child: SmallText(
                      text: product.description,
                      size: DimensionStaticHeight(context, 18),
                    ),
                    //child: DetailUnderImage(text: product.description,),
                  ),
                ],
              )),
        )
      ]),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: DimensionStaticWidth(context, 20 * 2.5),
                right: DimensionStaticWidth(context, 20 * 2.5),
                //top: DimensionStaticHeight(context, 10),
                //bottom: DimensionStaticHeight(context, 10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        icon: Icons.remove,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconsize: DimensionStaticHeight(context, 24)),
                  ),
                  BigText(
                    text: "\$${product.price}  X ${controller.inCartItems}",
                    color: AppColors.mainBlackColor,
                    size: DimensionStaticHeight(context, 22),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        icon: Icons.add,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconsize: DimensionStaticHeight(context, 24)),
                  ),
                ],
              ),
            ),
            Container(
              height: DimensionStaticHeight(context, 120),
              // padding: EdgeInsets.only(
              //   top: DimensionStaticHeight(context, 10),
              //   //bottom: DimensionStaticHeight(context, 10),
              // ),
              decoration: BoxDecoration(
                color: AppColors.buttonbackgroungColor,
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(DimensionStaticHeight(context, 20 * 2)),
                  topRight:
                      Radius.circular(DimensionStaticHeight(context, 20 * 2)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: DimensionStaticWidth(context, 25),
                    ),
                    padding: EdgeInsets.only(
                        top: DimensionStaticHeight(context, 20),
                        bottom: DimensionStaticHeight(context, 20),
                        left: DimensionStaticWidth(context, 20),
                        right: DimensionStaticWidth(context, 20)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            DimensionStaticHeight(context, 20)),
                        color: Colors.white),
                    child: Container(
                      // ignore: sort_child_properties_last
                      child: AppIcon(
                          icon: Icons.favorite,
                          iconColor: AppColors.mainColor,
                          backgroundColor: Colors.white70,
                          iconsize: DimensionStaticHeight(context, 24)),
                      width: DimensionStaticHeight(context, 25),
                      height: DimensionStaticHeight(context, 20),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: DimensionStaticWidth(context, 25),
                      ),
                      padding: EdgeInsets.only(
                          top: DimensionStaticHeight(context, 20),
                          bottom: DimensionStaticHeight(context, 20),
                          left: DimensionStaticWidth(context, 20),
                          right: DimensionStaticWidth(context, 20)),
                      // ignore: sort_child_properties_last
                      child: BigText(
                        text: "\$${product.price} ! Add ti cart.",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              DimensionStaticHeight(context, 20)),
                          color: AppColors.mainColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
