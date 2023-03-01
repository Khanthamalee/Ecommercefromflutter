import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/directory/pages/cart/cart_page.dart';
import 'package:ecommerce/directory/pages/main_goods_page.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/CardContainer.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:ecommerce/widget/widget_detail_underimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

//Detail PageView.builder

// ignore: must_be_immutable
class PopularGoodsDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularGoodsDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    print("class PopularGoodsDetail  :product ${product.name}");
    //จำนวนเริ่มต้น = 0
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    //print("page is id $pageId ");
    //print("product name is ${product.name}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: DimensionStaticHeight(context, 350),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img),
                  ),
                ),
              )),
          //Top icon Back and Cart
          Positioned(
              top: DimensionStaticHeight(context, 40),
              left: DimensionStaticWidth(context, 20),
              right: DimensionStaticWidth(context, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RounteHelper.getCartPage());
                        } else {
                          Get.toNamed(RounteHelper.getInitial());
                        }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RounteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  ),
                                )
                              : Container(),
                          controller.totalItems >= 1 &&
                                  controller.totalItems <= 9
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
                              : controller.totalItems > 9
                                  ? Positioned(
                                      top: DimensionStaticHeight(context, 4),
                                      right: DimensionStaticWidth(context, 4),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: BigText(
                                          text: Get.find<
                                                  PopularProductController>()
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
                ],
              )),
          //Detail Under image
          Positioned(
              left: 0,
              right: 0,
              top: DimensionStaticHeight(context, 350 - 20),
              bottom: DimensionStaticHeight(context, 20),
              child: Container(
                padding: EdgeInsets.only(
                    left: DimensionStaticWidth(context, 20),
                    right: DimensionStaticWidth(context, 20),
                    top: DimensionStaticHeight(context, 20)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      DimensionStaticHeight(context, 20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SumCardContainer(context, product.name, product.stars),
                    DimensionheightWidget(context, 20),
                    BigText(
                      text: "Introduce",
                      size: DimensionStaticHeight(context, 18),
                      color: Colors.black45,
                    ),
                    DimensionheightWidget(context, 15),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DetailUnderImage(
                          text: product.description!,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
      //Bottom Navigation bar เพิ่มลดสินค้า
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProducts) {
        return Container(
          height: DimensionStaticHeight(context, 100),
          padding: EdgeInsets.only(
              top: DimensionStaticHeight(context, 10),
              bottom: DimensionStaticHeight(context, 20)),
          decoration: BoxDecoration(
            color: AppColors.buttonbackgroungColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimensionStaticHeight(context, 20 * 2)),
              topRight: Radius.circular(DimensionStaticHeight(context, 20 * 2)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: DimensionStaticHeight(context, 20)),
                padding: EdgeInsets.only(
                    top: DimensionStaticHeight(context, 20),
                    bottom: DimensionStaticHeight(context, 20),
                    left: DimensionStaticWidth(context, 20),
                    right: DimensionStaticWidth(context, 20)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        DimensionStaticHeight(context, 20)),
                    color: Colors.white),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProducts.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    DimensionwidthWidget(context, 10),
                    BigText(text: popularProducts.inCartItems.toString()),
                    DimensionwidthWidget(context, 10),
                    GestureDetector(
                        onTap: () {
                          popularProducts.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProducts.addItem(product);
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
                    text: "\$${product.price} | Add it cart.",
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
        );
      }),
    );
  }
}
