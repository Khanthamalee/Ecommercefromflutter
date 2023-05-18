import 'package:ecommerce/base/cuatom_loading.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/car_controller.dart';
import 'package:ecommerce/controllers/profile_controlle.dart';
import 'package:ecommerce/directory/pages/account/account_widget.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/util/color.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (_userLoggedIn) {
      Get.find<ProfileUserController>().getProfileUserList();
      print("ล็อกอินแล้ว");
    }
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Container(
              height: DimensionStaticHeight(context, 100),
              padding: EdgeInsets.only(
                top: DimensionStaticHeight(context, 45),
              ),
              child: BigText(
                text: "โปรไฟล์",
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.mainColor),
      body: GetBuilder<ProfileUserController>(builder: (controller) {
        print(
            "controller.profileuserProductList :${controller.profileModel!.user}");
        var datacontroller = controller.profileModel!;
        var usercontroller = datacontroller.user!;
        var addresscontroller = datacontroller.homeaddress!['addressname'];
        return _userLoggedIn
            ? (controller.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Stack(children: [
                      Container(
                        child: Column(children: [
                          DimensionheightWidget(context, 10),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              child: const Center(
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      "assets/image_icon_app/logo.png"),
                                ),
                              ),
                            ),
                          ),
                          DimensionheightWidget(context, 10),
                          AccountWidget(
                            text:
                                "${usercontroller["firstname"]}  ${usercontroller["lastname"]}",
                            iconColor: Colors.white,
                            bgiconColor: AppColors.mainColor,
                            icon: Icons.person_outline_outlined,
                          ),
                          DimensionheightWidget(context, 10),
                          AccountWidget(
                            text: "${datacontroller.phone}",
                            iconColor: Colors.white,
                            bgiconColor: Colors.lightGreenAccent.shade700,
                            icon: Icons.phone_bluetooth_speaker_outlined,
                          ),
                          DimensionheightWidget(context, 10),
                          AccountWidget(
                            text: "${usercontroller["email"]}",
                            iconColor: Colors.white,
                            bgiconColor: Colors.blueAccent,
                            icon: Icons.email_outlined,
                          ),
                          DimensionheightWidget(context, 10),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RounteHelper.addAddressPage);
                            },
                            child: AccountWidget(
                              text: addresscontroller,
                              iconColor: Colors.white,
                              bgiconColor: Color(0xFFfcab88),
                              icon: Icons.location_on_outlined,
                              maxlines: 4,
                              height: 100,
                            ),
                          ),
                          DimensionheightWidget(context, 10),
                          AccountWidget(
                            text: "จำนวน order ${datacontroller.orderCount}",
                            iconColor: Colors.white,
                            bgiconColor: Colors.red.shade400,
                            icon: Icons.comment_bank_outlined,
                          ),
                          DimensionheightWidget(context, 10),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().userlogout();
                                Get.find<CartController>().clear();
                                Get.find<CartController>().clearCartHistory();
                                Get.toNamed(RounteHelper.getSignInPage());
                              } else {
                                print('คุณยังไม่เข้าสู่ระบบ');
                              }
                            },
                            child: AccountWidget(
                              text: "ออกจากระบบ",
                              iconColor: Colors.white,
                              bgiconColor: Colors.red.shade400,
                              icon: Icons.comment_bank_outlined,
                            ),
                          ),
                          DimensionheightWidget(context, 10),
                        ]),
                      ),
                      Positioned(
                        top: DimensionStaticHeight(context, 130),
                        left: DimensionStaticWidth(context, 220),
                        child: GestureDetector(
                          onTap: () {
                            print("แก้ไขโปรไฟล์");
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: BigText(
                                        text: "แก้ไขโปรไฟล์",
                                        size: 12,
                                        color: Colors.black45,
                                      )),
                                  color: Colors.white60,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                : CustomLoading())
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: DimensionStaticHeight(context, 20 * 8),
                        margin: EdgeInsets.only(
                            left: DimensionStaticWidth(context, 20),
                            right: DimensionStaticWidth(context, 20)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                DimensionStaticHeight(context, 20)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/image_icon_app/logo.png"))),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RounteHelper.signInPage);
                        },
                        child: Container(
                          width: double.infinity,
                          height: DimensionStaticHeight(context, 20 * 5),
                          margin: EdgeInsets.only(
                              left: DimensionStaticWidth(context, 20),
                              right: DimensionStaticWidth(context, 20)),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(
                                DimensionStaticHeight(context, 20)),
                          ),
                          child: BigText(
                            text: "กรุณาเข้าสู่ระบบ",
                            color: Colors.white,
                            size: DimensionStaticHeight(context, 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
