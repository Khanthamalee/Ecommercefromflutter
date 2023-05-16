import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final TextEditingController texteditingcontroller;
  final String hinttext;
  final IconData Icontext;
  final double height;
  bool isObscureText;
  AddressWidget(
      {Key? key,
      required this.texteditingcontroller,
      this.hinttext = "",
      required this.Icontext,
      this.height = 60,
      this.isObscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: DimensionStaticWidth(context, 45),
        right: DimensionStaticWidth(context, 45),
      ),
      child: Container(
        height: height == 0 ? 60 : height,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(DimensionStaticHeight(context, 20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: const Offset(1, 10),
                  color: Colors.grey.withOpacity(0.2)),
            ]),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          obscureText: isObscureText ? true : false,
          controller: texteditingcontroller,
          decoration: InputDecoration(
              hintText: hinttext == "" ? "" : hinttext,
              prefixIcon: Icon(
                Icontext,
                color: AppColors.yellowColor,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(DimensionStaticHeight(context, 30)),
                  borderSide:
                      const BorderSide(width: 1.0, color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(DimensionStaticHeight(context, 30)),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1.0))),
        ),
      ),
    );
  }
}
