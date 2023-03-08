import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/controllers/popular_product_controller.dart';
import 'package:ecommerce/directory/goods/goods_detail_popular.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/app_constants.dart';

import 'package:ecommerce/widget/CardContainer.dart';
import 'package:ecommerce/widget/WidgetRecommended.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/dimensionWidget.dart';
import '../../widget/icon_text_widget.dart';

class GoodsPageBody extends StatefulWidget {
  const GoodsPageBody({super.key});

  @override
  State<GoodsPageBody> createState() => _GoodsPageBodyState();
}

class _GoodsPageBodyState extends State<GoodsPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  late int index;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        //scalepage x unit pixel
        _currPageValue = pageController.page!;
        //print("Current value is " + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GetBuilder<PopularProductController>(builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    //color: Colors.redAccent,
                    height: DimensionStaticHeight(context, 320),

                    child: PageView.builder(
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return _buildPageItem(
                              index, popularProducts.popularProductList[index]);
                        },
                        itemCount: popularProducts.popularProductList.length),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          }),
          //dots_indicator
          GetBuilder<PopularProductController>(builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                  size: Size.square(DimensionStaticHeight(context, 9)),
                  activeSize: Size(DimensionStaticWidth(context, 20),
                      DimensionStaticHeight(context, 9)),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          DimensionStaticHeight(context, 5)))),
            );
          }),

          //Recommended text
          DimensionheightWidget(context, 20),
          Container(
            margin: EdgeInsets.only(
              left: DimensionStaticWidth(context, 20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DimensionwidthWidget(context, 15),
                BigText(text: "Recommended"),
                DimensionwidthWidget(context, 10),
                Container(
                  margin: EdgeInsets.only(
                      bottom: DimensionStaticHeight(context, 3)),
                  child: BigText(
                    text: ".",
                    color: Colors.black26,
                  ),
                ),
                DimensionwidthWidget(context, 10),
                Container(
                  child: SmallText(
                    text: "Goods pairing",
                  ),
                ),
              ],
            ),
          ),
          const MyWidgetReccommended(),
          //DimensionheightWidget(context, 5),
          //List of goods and index
          /*const SizedBox(
            //height: DimensionStaticHeight(context, 650),
            child: MyWidgetReccommended(),
          ),*/
        ],
      ),
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    //ทำอนิเมชันเวลาเลื่อนการ์ด
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RounteHelper.getPopularGoods(index, "home"));
            },
            child: Container(
              height: DimensionStaticHeight(context, 220),
              margin: EdgeInsets.only(
                  left: DimensionStaticWidth(context, 10),
                  right: DimensionStaticWidth(context, 10)),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(DimensionStaticHeight(context, 30)),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(-5, 0)),
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(5, 0)),
                  ],
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(popularProduct.img!),
                      /*image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct.img!),*/
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: DimensionStaticHeight(context, 120),
              margin: EdgeInsets.only(
                  left: DimensionStaticWidth(context, 30),
                  right: DimensionStaticWidth(context, 30),
                  bottom: DimensionStaticHeight(context, 30)),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionStaticHeight(context, 20)),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                ],
              ),
              child: Container(
                  padding: EdgeInsets.only(
                      top: DimensionStaticHeight(context, 10),
                      left: DimensionStaticWidth(context, 15),
                      right: DimensionStaticWidth(context, 15)),
                  child: SumCardContainer(
                      context, popularProduct.name!, popularProduct.stars!)),
            ),
          ),
        ],
      ),
    );
  }
}
