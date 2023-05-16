import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/material.dart';

class SignUpWidth extends StatelessWidget {
  final TextEditingController texteditingcontroller;
  final String hinttext;
  final String prefixText;
  final IconData Icontext;
  const SignUpWidth({
    Key? key,
    required this.texteditingcontroller,
    this.hinttext = "",
    required this.Icontext,
    this.prefixText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensionStaticHeight(context, 27)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: const Offset(1, 10),
                color: Colors.grey.withOpacity(0.2)),
          ]),
      child: TextField(
        controller: texteditingcontroller,
        decoration: InputDecoration(
            hintText: hinttext == "" ? "" : hinttext,
            suffixText: prefixText == "" ? "" : prefixText,
            prefixIcon: Icon(
              Icontext,
              color: AppColors.yellowColor,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(DimensionStaticHeight(context, 30)),
                borderSide: const BorderSide(width: 1.0, color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(DimensionStaticHeight(context, 30)),
                borderSide: const BorderSide(color: Colors.white, width: 1.0))),
      ),
    );
  }
}
