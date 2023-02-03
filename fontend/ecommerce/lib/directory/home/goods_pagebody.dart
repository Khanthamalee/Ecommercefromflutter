import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/icon_text_widget.dart';

class GoodsPageBody extends StatefulWidget {
  const GoodsPageBody({super.key});

  @override
  State<GoodsPageBody> createState() => _GoodsPageBodyState();
}

class _GoodsPageBodyState extends State<GoodsPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
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
          height: 320,
          child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return _buildPageItem(index);
              },
              itemCount: GoodsItemsList.length),
        ),
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
              size: Size.square(9.0),
              activeSize: Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 220,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
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
              height: 120,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  // BoxShadow(
                  //     color: Color(0xFFe8e8e8),
                  //     blurRadius: 5.0,
                  //     offset: Offset(-5, 0)),
                  // BoxShadow(
                  //     color: Color(0xFFe8e8e8),
                  //     blurRadius: 5.0,
                  //     offset: Offset(2, 0)),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: GoodsnamesList[index].title),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) {
                              return Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "5.0"),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "2.5 k Comment")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconandTextWidget(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconcolor: AppColors.iconColor1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IconandTextWidget(
                          icon: Icons.location_on,
                          text: "1.7 km.",
                          iconcolor: AppColors.mainColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IconandTextWidget(
                          icon: Icons.access_time_filled_rounded,
                          text: "32 min",
                          iconcolor: AppColors.iconColor2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
