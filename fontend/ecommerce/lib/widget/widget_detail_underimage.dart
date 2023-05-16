import 'package:ecommerce/util/color.dart';
import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';

//การสืบทอดคุณสมบัติของ class StatefulWidget คลาสแม่
class DetailUnderImage extends StatefulWidget {
  final String text;
  const DetailUnderImage({Key? key, required this.text}) : super(key: key);

  @override
  State<DetailUnderImage> createState() => _DetailUnderImageState();
}

class _DetailUnderImageState extends State<DetailUnderImage> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  //from util/dimensionWidget.dart
  double textHeight = Dimensions.textheight;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(DimensionStaticWidth(context, 10)),
      child: SingleChildScrollView(
        child: secondHalf.isEmpty
            ? SmallText(text: firstHalf)
            : Column(
                children: [
                  SmallText(
                    text: hiddenText
                        ? (firstHalf + "...")
                        : (firstHalf + secondHalf),
                    size: DimensionStaticHeight(context, 16),
                    color: Colors.black45,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: "Show more",
                          color: AppColors.mainColor,
                          size: DimensionStaticHeight(context, 16),
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                          size: DimensionStaticHeight(context, 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
