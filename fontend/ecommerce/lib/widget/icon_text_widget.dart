import 'package:ecommerce/widget/smalltext.dart';
import 'package:flutter/material.dart';

import '../util/dimensionWidget.dart';

class IconandTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconcolor;
  const IconandTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconcolor,
          size: DimensionStaticHeight(context, 24),
        ),
        DimensionwidthWidget(context, 5),
        SmallText(text: text)
      ],
    );
  }
}
