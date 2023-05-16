import 'package:ecommerce/base/cuatom_loading.dart';
import 'package:ecommerce/base/show_custom_snackbar.dart';
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/data/repository/auth_repo.dart';
import 'package:ecommerce/directory/pages/sign_in/sign_in.dart';
import 'package:ecommerce/directory/pages/sign_up/sigh_up_widget.dart';

import 'package:ecommerce/directory/pages/sign_up/sign_up_width.dart';
import 'package:ecommerce/model/create_token_model.dart';
import 'package:ecommerce/model/signup_body_model.dart';
import 'package:ecommerce/rountes/rounte_helper.dart';
import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/bigtext.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  final String emailotp;

  const SignUpPage({Key? key, required this.emailotp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmpasswordController =
        TextEditingController();
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    var signUpImages = ["google.gif", "facebook.gif", "twitter.gif"];

    void _registration(AuthController authController) {
      //var authController = Get.find<AuthController>();
      String firstname = firstnameController.text.trim();
      String lastname = lastnameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmpassword = confirmpasswordController.text.trim();
      String username = usernameController.text.trim();

      if (firstname.isEmpty) {
        showCustomSnackBar("กรุณากรอกชื่อของคุณ", Colors.redAccent,
            title: "ชื่อจริงของคุณ");
      } else if (lastname.isEmpty) {
        showCustomSnackBar("กรุณากรอกนามสกุลของคุณ", Colors.redAccent,
            title: "นามสกุลของคุณ");
      } else if (email.isEmpty) {
        showCustomSnackBar("กรุณากรอกอีเมลล์ของคุณ", Colors.redAccent,
            title: "อีเมลล์ของคุณ");
      } else if (email != emailotp) {
        showCustomSnackBar(
            "กรุณากรอกชื่อ ${emailotp} เท่านั้น", Colors.redAccent,
            title: "อีเมลล์ของคุณ");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("กรุณากรอกอีเมลล์ให้ถูกต้อง เช่น Example@gmail.com",
            Colors.redAccent,
            title: "ตรวจสอบแล้วไม่ใช่ email");
      } else if (username.isEmpty) {
        showCustomSnackBar("กรุณากรอกเบอร์โทรศัพท์ของคุณ", Colors.redAccent,
            title: "เบอร์โทรศัพท์ของคุณ");
      } else if (!GetUtils.isPhoneNumber(username)) {
        showCustomSnackBar("กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง เช่น 0123456789",
            Colors.redAccent,
            title: "ไม่ใช่เบอร์โทร");
      } else if (password.isEmpty) {
        showCustomSnackBar("กรุณากรอกรหัสผ่านของคุณ", Colors.redAccent,
            title: "รหัสผ่านของคุณ");
      } else if (password.length < 8) {
        showCustomSnackBar(
            "รหัสผ่านของคุณต้องไม่น้อยกว่า 8 ตัวอักษร", Colors.redAccent,
            title: "รหัสผ่านของคุณ");
      } else if (password != confirmpassword) {
        showCustomSnackBar("รหัสผ่านของคุณไม่ตรงกัน", Colors.redAccent,
            title: "กรุณากรอกรหัสผ่านใหม่อีกครั้ง");
      } else {
        SignUpBody signUpBody = SignUpBody(
            firstname: firstname,
            lastname: lastname,
            email: email,
            username: username,
            password: password,
            confirmpassword: confirmpassword);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("เข้าสู่ระบบ");
            print("status.message : ${status.message}");
            showCustomSnackBar("เข้าสู่ระบบได้เลย!", Colors.green.shade400,
                title: "ข้อมูลเสร็จสมบูรณ์");
            Get.toNamed(RounteHelper.getSignInPage());
          } else {
            showCustomSnackBar(
                title: "โปรดตรวจสอบ",
                '${status.message}',
                Colors.orange.shade400);
          }
        });

        print(
          "firstname : ${signUpBody.firstname}, lastname : ${signUpBody.lastname},  email : ${signUpBody.email}, phone : ${signUpBody.username} password : ${signUpBody.password}",
        );
        print(signUpBody);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: DimensionStaticHeight(context, 45)),
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
                        top: DimensionStaticHeight(context, 15),
                        left: DimensionStaticWidth(context, 40),
                        bottom: DimensionStaticHeight(context, 20),
                        right: DimensionStaticWidth(context, 31),
                      ),
                      child: SmallText(
                        text: "ขั้นตอนที่ 3 กรุณากรอกข้อมูลของคุณให้เรียบร้อย",
                        size: 15,
                      ),
                    ),
                    DimensionheightWidget(context, 10),
                    Padding(
                      padding: EdgeInsets.only(
                        left: DimensionStaticWidth(context, 45),
                        right: DimensionStaticWidth(context, 45),
                      ),
                      child: Row(
                        children: [
                          SignUpWidth(
                            texteditingcontroller: firstnameController,
                            hinttext: "First name",
                            Icontext: Icons.person_outline_outlined,
                          ),
                          DimensionwidthWidget(context, 10),
                          SignUpWidth(
                            texteditingcontroller: lastnameController,
                            hinttext: "Last name",
                            Icontext: Icons.groups_outlined,
                          ),
                        ],
                      ),
                    ),
                    DimensionheightWidget(context, 10),
                    SignUpWidget(
                      texteditingcontroller: usernameController,
                      hinttext: "Phone",
                      Icontext: Icons.local_phone_outlined,
                    ),
                    DimensionheightWidget(context, 10),
                    SignUpWidget(
                      texteditingcontroller: emailController,
                      hinttext: emailotp,
                      Icontext: Icons.email_outlined,
                    ),
                    DimensionheightWidget(context, 10),
                    SignUpWidget(
                      isObscureText: true,
                      texteditingcontroller: passwordController,
                      hinttext: "Password",
                      Icontext: Icons.lock_outline,
                    ),
                    DimensionheightWidget(context, 10),
                    SignUpWidget(
                      isObscureText: true,
                      texteditingcontroller: confirmpasswordController,
                      hinttext: "Password again",
                      Icontext: Icons.lock_outline,
                    ),
                    DimensionheightWidget(context, 15),
                    GestureDetector(
                      onTap: () {
                        _registration(_authController);
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
                            text: "สมัครสมาชิก",
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
                    DimensionheightWidget(context, 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(
                          text: "หากท่านเป็นสมาชิกอยู่แล้ว ",
                          size: DimensionStaticHeight(context, 15),
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
                                fontStyle: FontStyle.normal,
                                fontSize: DimensionStaticHeight(context, 16),
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "หรือเข้าสู่ระบบโดย",
                              style: GoogleFonts.mali(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: DimensionStaticHeight(context, 15),
                              )),
                        ),
                        DimensionwidthWidget(context, 10),
                        const Icon(
                          Icons.arrow_circle_down_outlined,
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                    DimensionheightWidget(context, 10),
                    Wrap(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: DimensionStaticHeight(context, 30),
                                  backgroundImage: AssetImage(
                                      "assets/image_icon_app/${signUpImages[index]}"),
                                ),
                              )),
                    ),
                    DimensionheightWidget(context, 30),
                  ],
                ))
            : const CustomLoading();
      }),
    );
  }
}
