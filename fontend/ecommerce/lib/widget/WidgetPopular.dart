import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/CardContainer.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore: non_constant_identifier_names
Widget WidgetPopular(BuildContext context) {
  return ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: GoodsItemsList.length,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(
          left: DimensionStaticWidth(context, 20),
          right: DimensionStaticWidth(context, 20),
          bottom: DimensionStaticHeight(context, 10),
        ),
        child: Row(
          children: [
            Container(
              width: DimensionStaticWidth(context, 120),
              height: DimensionStaticHeight(context, 120),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionStaticHeight(context, 20)),
                color: Colors.white38,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(GoodsItemsList[index].directoryimage),
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
                      left: DimensionStaticWidth(context, 20),
                      right: DimensionStaticWidth(context, 20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: GoodsnamesList[index].title),
                      DimensionheightWidget(context, 5),
                      SmallText(text: 'สายพันธุ์ เจริญลาภ'),
                      DimensionheightWidget(context, 10),
                      SubCardContainer("มีสินค้า", "5 k.m", "30 นาที")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
