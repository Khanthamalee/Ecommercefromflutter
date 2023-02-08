import 'package:ecommerce/controllers/recommended_product_controller.dart';
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
            const AppIcon(icon: Icons.shopping_cart_outlined)
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
      bottomNavigationBar: Column(
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
                AppIcon(
                    icon: Icons.remove,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconsize: DimensionStaticHeight(context, 24)),
                BigText(
                  text: "\$${product.price} " + " X " + " 0",
                  color: AppColors.mainBlackColor,
                  size: DimensionStaticHeight(context, 22),
                ),
                AppIcon(
                    icon: Icons.add,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconsize: DimensionStaticHeight(context, 24)),
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
                Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
