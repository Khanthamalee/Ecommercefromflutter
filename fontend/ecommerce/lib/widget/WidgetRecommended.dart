import 'package:ecommerce/controllers/recommended_product_controller.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/CardContainer.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyWidgetReccommended extends StatefulWidget {
  const MyWidgetReccommended({super.key});

  @override
  State<MyWidgetReccommended> createState() => _MyWidgetReccommendedState();
}

class _MyWidgetReccommendedState extends State<MyWidgetReccommended> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedProductController>(
        builder: (recommendedProducts) {
      return recommendedProducts.isLoaded
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (context, index) {
                return WidgetRecommended(context, index,
                    recommendedProducts.recommendedProductList[index]);
              })
          : CircularProgressIndicator(
              color: AppColors.mainColor,
            );
    });
  }

  // ignore: non_constant_identifier_names
  Widget WidgetRecommended(
      BuildContext context, int index, ProductModel recommendedProduct) {
    return Container(
      margin: EdgeInsets.only(
        left: DimensionStaticWidth(context, 20),
        right: DimensionStaticWidth(context, 20),
        bottom: DimensionStaticHeight(context, 20),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RounteHelper.getRecommededGoods(index, "home"));
        },
        child: Row(
          children: [
            Container(
              width: DimensionStaticWidth(context, 140),
              height: DimensionStaticHeight(context, 120),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionStaticHeight(context, 20)),
                color: Colors.white38,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(recommendedProduct.img!),
                  /*image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        recommendedProduct.img!)*/
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: DimensionStaticHeight(context, 120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            DimensionStaticHeight(context, 20))),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: DimensionStaticWidth(context, 10),
                      right: DimensionStaticWidth(context, 10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: recommendedProduct.name!),
                      DimensionheightWidget(context, 5),
                      SmallText(text: 'สายพันธุ์ เจริญลาภ'),
                      DimensionheightWidget(context, 5),
                      SubCardContainer("มีสินค้า", "5 k.m", "30 นาที")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
