import 'package:ecommerce/base/cuatom_loading.dart';
import 'package:ecommerce/base/show_custom_snackbar.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/directory/pages/resetpassword/resetpassword_page.dart';
import 'package:ecommerce/directory/pages/sign_up/authenticate_email.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_page.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_widget.dart';
import 'package:ecommerce/model/create_token_model.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resetpassword/changepassword_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    late TextEditingController phoneController = TextEditingController();
    late TextEditingController passwordController = TextEditingController();
    late List<String> signUpImages = ["corn.png", "flo.jpg", "piecelily.png"];

    void _loginuser(AuthController authController) {
      //var authController = Get.find<AuthController>();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      LoginData loginData = LoginData(
        username: phone,
        password: password,
      );

      authController.loginuser(loginData).then((status) {
        if (status.isSuccess) {
          print("เข้าสู่ระบบได้แล้ว");

          var token = status.message;

          Map<String, dynamic> datalogin = {
            'Token': '${token}',
            'username': '${loginData.username}',
            'password': '${loginData.password}'
          };
          print("datalogin : ${datalogin.toString()}");

          //Get.to(() => const AuthEmail());
          Get.toNamed(RounteHelper.getSplashPage(token.toString()));
          showCustomSnackBar(
              'บ้านสวนนาอุดม',
              title: 'ยินดีต้อนรับเข้าสู่',
              Colors.green.shade400);
        } else {
          showCustomSnackBar(
              'พาสเวิร์ดหรือเบอร์โทรผิดพลาด', Colors.orange.shade400);
        }
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: DimensionStaticHeight(context, 45),
                        ),
                        child: Container(
                          child: const Center(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage("assets/image_icon_app/logo.png"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: DimensionStaticHeight(context, 20),
                            left: DimensionStaticWidth(context, 30)),
                        child: BigText(text: "ยินดีต้อนรับ", size: 40),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: DimensionStaticWidth(context, 31),
                          bottom: DimensionStaticHeight(context, 20),
                        ),
                        child: SmallText(
                          text: "ล็อกอิน เข้าสู่ระบบกันเลย",
                          size: 15,
                        ),
                      ),
                      DimensionheightWidget(context, 10),
                      SignUpWidget(
                        texteditingcontroller: phoneController,
                        hinttext: "เบอร์โทรศัพท์",
                        Icontext: Icons.local_phone_outlined,
                      ),
                      DimensionheightWidget(context, 10),
                      SignUpWidget(
                        isObscureText: true,
                        texteditingcontroller: passwordController,
                        hinttext: "รหัสผ่าน",
                        Icontext: Icons.password_outlined,
                      ),
                      DimensionheightWidget(context, 15),
                      GestureDetector(
                        onTap: () {
                          _loginuser(_authController);
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: DimensionStaticHeight(context, 20),
                                bottom: DimensionStaticHeight(context, 20),
                                left: DimensionStaticWidth(context, 20),
                                right: DimensionStaticWidth(context, 20)),
                            // ignore: sort_child_properties_last
                            child: BigText(
                              text: "ล็อกอิน",
                              color: Colors.white,
                              size: DimensionStaticHeight(context, 18),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    DimensionStaticHeight(context, 20)),
                                color: AppColors.mainColor),
                          ),
                        ),
                      ),
                      DimensionheightWidget(context, 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "ยังไม่มีบัญชี",
                                style: GoogleFonts.mali(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionStaticHeight(context, 15),
                                )),
                          ),
                          DimensionwidthWidget(context, 10),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.amberAccent,
                          ),
                          DimensionwidthWidget(context, 10),
                          RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                      Get.toNamed(RounteHelper.getAuthEmail()),
                                      transition: Transition.fadeIn),
                                text: "สมัครสมาชิก",
                                style: GoogleFonts.mali(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionStaticHeight(context, 15),
                                )),
                          ),
                        ],
                      ),
                      DimensionheightWidget(context, 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "ลืมรหัสผ่าน",
                                style: GoogleFonts.mali(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionStaticHeight(context, 15),
                                )),
                          ),
                          DimensionwidthWidget(context, 10),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.amberAccent,
                          ),
                          DimensionwidthWidget(context, 10),
                          RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                      Get.toNamed(
                                          RounteHelper.getResetPasswordPage()),
                                      transition: Transition.fadeIn),
                                text: "ลืมรหัสผ่าน",
                                style: GoogleFonts.mali(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionStaticHeight(context, 15),
                                )),
                          ),
                        ],
                      ),
                      DimensionheightWidget(context, 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "เปลี่ยนรหัสผ่าน",
                                style: GoogleFonts.mali(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionStaticHeight(context, 15),
                                )),
                          ),
                          DimensionwidthWidget(context, 10),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.amberAccent,
                          ),
                          DimensionwidthWidget(context, 10),
                          RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                      Get.toNamed(
                                          RounteHelper.getchangePassword()),
                                      transition: Transition.fadeIn),
                                text: "เปลี่ยนรหัสผ่าน",
                                style: GoogleFonts.mali(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionStaticHeight(context, 15),
                                )),
                          ),
                        ],
                      ),
                      DimensionheightWidget(context, 45),
                    ],
                  ),
                )
              : const CustomLoading();
        }));
  }
}
