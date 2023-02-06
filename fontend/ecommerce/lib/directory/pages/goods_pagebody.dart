import 'package:dots_indicator/dots_indicator.dart';

import 'package:ecommerce/widget/CardContainer.dart';
import 'package:ecommerce/widget/WidgetPopular.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.redAccent,
          height: DimensionStaticHeight(context, 320),
          child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return _buildPageItem(index);
              },
              itemCount: GoodsItemsList.length),
        ),
        //dots_indicator
        DotsIndicator(
          dotsCount: GoodsItemsList.length,
          position: _currPageValue,
          decorator: DotsDecorator(
              size: Size.square(DimensionStaticHeight(context, 9)),
              activeSize: Size(DimensionStaticWidth(context, 20),
                  DimensionStaticHeight(context, 9)),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      DimensionStaticHeight(context, 5)))),
        ),
        //popular text
        DimensionheightWidget(context, 20),
        Container(
          margin: EdgeInsets.only(left: DimensionStaticWidth(context, 30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              DimensionwidthWidget(context, 10),
              Container(
                margin:
                    EdgeInsets.only(bottom: DimensionStaticHeight(context, 3)),
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
        DimensionheightWidget(context, 10),
        //List of goods and index
        Container(
            height: DimensionStaticHeight(context, 600),
            child: WidgetPopular(context)),
      ],
    );
  }

  Widget _buildPageItem(int index) {
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
          Container(
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
                    image: AssetImage(GoodsItemsList[index].directoryimage),
                    fit: BoxFit.cover)),
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
                  child:
                      SumCardContainer(context, GoodsnamesList[index].title)),
            ),
          ),
        ],
      ),
    );
  }
}
