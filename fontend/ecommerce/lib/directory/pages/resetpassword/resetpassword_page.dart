import 'package:ecommerce/directory/pages/sign_in/sign_in.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_widget.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                child: BigText(text: "คุณลืมรหัสผ่านใช่หรือไม่? ", size: 25),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: DimensionStaticHeight(context, 15),
                  left: DimensionStaticWidth(context, 31),
                  bottom: DimensionStaticHeight(context, 20),
                ),
                child: SmallText(
                  text: "กรุณากรอกอีเมลล์เพื่อรีเซ็ตรหัสผ่าน",
                  size: 15,
                ),
              ),
              DimensionheightWidget(context, 10),
              SignUpWidget(
                texteditingcontroller: emailController,
                hinttext: "Email",
                Icontext: Icons.email_outlined,
              ),
              DimensionheightWidget(context, 15),
              GestureDetector(
                onTap: () {
                  //controller.addItem(product);
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
                      text: "รีเซ็ตรหัสผ่าน",
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
              DimensionheightWidget(context, 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "กลับ",
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
                          ..onTap = () => Get.to(() => const SignInPage(),
                              transition: Transition.fadeIn),
                        text: "เข้าสู่ระบบ",
                        style: GoogleFonts.mali(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: DimensionStaticHeight(context, 15),
                        )),
                  ),
                ],
              ),
              DimensionheightWidget(context, 10),
            ],
          ),
        ));
  }
}
