import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/util/goodsitem.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/widget_detail_underimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecommenededGoodsDetail extends StatelessWidget {
  const RecommenededGoodsDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          //Big image

          SliverAppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  AppIcon(icon: Icons.clear),
                  AppIcon(icon: Icons.shopping_cart_outlined)
                ]),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(DimensionStaticHeight(context, 50)),
              child: Container(
                // ignore: sort_child_properties_last
                child: Center(
                  child: BigText(
                    text: "Silver app bar",
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
                        topRight: Radius.circular(
                            DimensionStaticHeight(context, 20)))),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: DimensionStaticHeight(context, 300),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image_ui/green.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: DimensionStaticHeight(context, 900),
                child: Column(
                  children: [
                    Container(
                      child: DetailUnderImage(text: (DetailList[1].detail)),
                    ),
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: DimensionStaticWidth(context, 20 * 2.5),
                right: DimensionStaticWidth(context, 20 * 2.5),
                top: DimensionStaticHeight(context, 20),
                bottom: DimensionStaticHeight(context, 20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    icon: Icons.remove,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconsize: DimensionStaticHeight(context, 24)),
                BigText(
                  text: " \$12.88 " + " X " + " 0 ",
                  color: AppColors.mainBlackColor,
                  size: DimensionStaticHeight(context, 24),
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
            padding: EdgeInsets.only(
                top: DimensionStaticHeight(context, 10),
                bottom: DimensionStaticHeight(context, 10)),
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
                      bottom: DimensionStaticHeight(context, 20)),
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
                      bottom: DimensionStaticHeight(context, 20)),
                  padding: EdgeInsets.only(
                      top: DimensionStaticHeight(context, 20),
                      bottom: DimensionStaticHeight(context, 20),
                      left: DimensionStaticWidth(context, 20),
                      right: DimensionStaticWidth(context, 20)),
                  // ignore: sort_child_properties_last
                  child: BigText(
                    text: "\$10 ! Add ti cart.",
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
