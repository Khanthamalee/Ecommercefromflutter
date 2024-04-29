import 'package:ecommerce/util/dimensionWidget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontsize;
  final double? redius;
  final IconData? icon;
  CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontsize,
      this.redius = 5,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : Theme.of(context).primaryColor,
        minimumSize: Size(width == null ? width! : Dimensions.screenWidth,
            height != null ? height! : DimensionStaticHeight(context, 50)),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(DimensionStaticHeight(context, redius))));
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.screenWidth,
        height: height ?? DimensionStaticHeight(context, 50),
        child: TextButton(
            onPressed: () {},
            style: _flatButton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          right: DimensionStaticHeight(context, 5),
                        ),
                        child: Icon(icon,
                            color: transparent
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor),
                      )
                    : SizedBox()
              ],
            )),
      ),
    );
  }
}
