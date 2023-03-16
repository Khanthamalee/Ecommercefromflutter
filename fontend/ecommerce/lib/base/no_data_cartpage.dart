import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/image_icon_app/logo.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        DimensionheightWidget(
          context,
          MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          text,
          style: GoogleFonts.mali(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Theme.of(context).disabledColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
