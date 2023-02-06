import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/icon_text_widget.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/bigtext.dart';

Widget SumCardContainer(BuildContext context, String text) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    BigText(text: text),
    DimensionheightWidget(context, 15),
    Row(
      children: [
        Wrap(
          children: List.generate(
            5,
            (index) {
              return Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: DimensionStaticHeight(context, 15),
              );
            },
          ),
        ),
        DimensionwidthWidget(context, 10),
        SmallText(text: "5.0"),
        DimensionwidthWidget(context, 10),
        SmallText(text: "2.5 k Comment")
      ],
    ),
    DimensionheightWidget(context, 20),
    SubCardContainer("Normal", "1.7 km.", "32 min"),
  ]);
}

Widget SubCardContainer(String text1, String text2, String text3) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconandTextWidget(
        icon: Icons.circle_sharp,
        text: text1,
        iconcolor: AppColors.iconColor1,
      ),
      IconandTextWidget(
        icon: Icons.location_on,
        text: text2,
        iconcolor: AppColors.mainColor,
      ),
      IconandTextWidget(
        icon: Icons.access_time_filled_rounded,
        text: text3,
        iconcolor: AppColors.iconColor2,
      )
    ],
  );
}
