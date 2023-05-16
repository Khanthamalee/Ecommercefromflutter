import 'package:ecommerce/directory/pages/sign_in/sign_in.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_page.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_widget.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthEmail extends StatefulWidget {
  const AuthEmail({super.key});

  @override
  State<AuthEmail> createState() => _AuthEmailState();
}

class _AuthEmailState extends State<AuthEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
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
              DimensionheightWidget(context, 10),
              Padding(
                padding: EdgeInsets.only(
                    top: DimensionStaticHeight(context, 20),
                    left: DimensionStaticWidth(context, 30)),
                child: BigText(text: "สมัครสมาชิก ", size: 25),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: DimensionStaticHeight(context, 15),
                  left: DimensionStaticWidth(context, 31),
                  bottom: DimensionStaticHeight(context, 20),
                ),
                child: SmallText(
                  text: "ขั้นตอนที่ 1 กรุณากรอก Email ของคุณ และ Send OTP",
                  size: 15,
                ),
              ),
              DimensionheightWidget(context, 10),
              SignUpWidget(
                texteditingcontroller: _emailController,
                hinttext: "Email",
                Icontext: Icons.email_outlined,
              ),
              DimensionheightWidget(context, 10),
              GestureDetector(
                onTap: () async {
                  myauth.setConfig(
                      appEmail: "me@rohitchouhan.com",
                      appName: "Email OTP",
                      userEmail: _emailController.text,
                      otpLength: 6,
                      otpType: OTPType.digitsOnly);
                  if (await myauth.sendOTP() == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("กรูณาตรวจสอบ OTP ที่ Email ของคุณ"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("ขออภัย,ไม่สามารถส่ง OTP ที่ Email นี้ได้"),
                    ));
                  }
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
                      text: "OTP to Email",
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
              Padding(
                padding: EdgeInsets.only(
                  top: DimensionStaticHeight(context, 15),
                  left: DimensionStaticWidth(context, 31),
                  bottom: DimensionStaticHeight(context, 20),
                ),
                child: SmallText(
                  text:
                      "ขั้นตอนที่ 2 กรุณาตรวจสอบ Email ของคุณ และกรอกรหัส OTP ที่ได้รับ",
                  size: 15,
                ),
              ),
              DimensionheightWidget(context, 10),
              SignUpWidget(
                texteditingcontroller: _otpController,
                hinttext: "OTP",
                Icontext: Icons.password_outlined,
              ),
              DimensionheightWidget(context, 15),
              GestureDetector(
                onTap: () async {
                  if (await myauth.verifyOTP(otp: _otpController.text) ==
                      true) {
                    var email = _emailController.text;
                    print(email);
                    Get.to(() => SignUpPage(emailotp: email));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP ได้รับการยืนยัน"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("OTP ไม่ถูกต้อง"),
                    ));
                  }
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
                      text: "Verify OTP",
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
                        text: "มีบัญชีแล้ว",
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
