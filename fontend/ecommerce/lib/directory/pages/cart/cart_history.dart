import 'dart:convert';
import 'package:ecommerce/base/no_data_cartpage.dart';
import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/app_icon.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  final String token;
  const CartHistory({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> cartItemsPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderTimeToList();
    print("cartItemsPerOrder : $cartItemsPerOrder");

    var ListCounter = 0;
    print("token in CartHistory: ${token}");
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[ListCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());

        var outputFormat = DateFormat("MM/dd/yyyy เวลา HH:mm:ss");
        var outputDate = outputFormat.format(inputDate);
        print(outputDate);
        return BigText(text: outputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
        body: Column(
      children: [
        Container(
          height: DimensionStaticHeight(context, 100),
          color: AppColors.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: DimensionStaticHeight(context, 45)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "ประวัติรายการสินค้า",
                color: Colors.white,
              ),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
                backgroundColor: AppColors.yellowColor,
              )
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().isNotEmpty
              ? Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                        top: DimensionStaticHeight(context, 20),
                        left: DimensionStaticWidth(context, 20),
                        right: DimensionStaticWidth(context, 20),
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: DimensionStaticHeight(context, 140),
                                margin: EdgeInsets.only(
                                    bottom: DimensionStaticHeight(context, 20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(ListCounter),
                                    DimensionheightWidget(context, 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (ListCounter <
                                                getCartHistoryList.length) {
                                              ListCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        DimensionStaticHeight(
                                                            context, 80),
                                                    width: DimensionStaticWidth(
                                                        context, 80),
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            DimensionStaticWidth(
                                                                context,
                                                                10 / 2)),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                DimensionStaticHeight(
                                                                    context,
                                                                    15 / 2)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                getCartHistoryList[
                                                                        ListCounter -
                                                                            1]
                                                                    .img!))),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        Container(
                                          height: DimensionStaticHeight(
                                              context, 80),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                  text: "รวม",
                                                  color: AppColors.titleColor),
                                              BigText(
                                                text:
                                                    "${itemsPerOrder[i].toString()} รายการ",
                                                color: AppColors.titleColor,
                                                size: DimensionStaticHeight(
                                                    context, 20),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      print(
                                                          "orderTime[i] ${orderTime[i]}");
                                                      print(jsonEncode(
                                                          getCartHistoryList[j]
                                                              .product));
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();

                                                  Get.toNamed(
                                                      RounteHelper.getCartPage(
                                                          1,
                                                          "cart-history",
                                                          token));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          DimensionStaticHeight(
                                                              context, 10)),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              DimensionStaticHeight(
                                                                  context,
                                                                  15 / 3)),
                                                      border: Border.all(
                                                          width:
                                                              DimensionStaticWidth(
                                                                  context, 1),
                                                          color: AppColors
                                                              .mainColor)),
                                                  child: SmallText(
                                                    text: "เพิ่มเติม",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      )),
                )
              : Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const NoDataPage(
                    text: "คุณยังไม่เคยทำรายการสินค้า",
                  ),
                );
        })
      ],
    ));
  }
}
