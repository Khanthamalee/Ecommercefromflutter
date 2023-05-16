import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/dimensionWidget.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final int maxlines;
  double size;
  TextOverflow overflow;
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis,
      this.maxlines = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxlines == 0 ? 1 : maxlines,
        overflow: overflow,
        style: GoogleFonts.mali(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: size == 0 ? DimensionStaticHeight(context, 18) : size));
  }
}
