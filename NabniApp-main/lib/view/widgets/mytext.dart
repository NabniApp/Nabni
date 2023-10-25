
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String? title;
  double? size;
  var maxline, fontstyle, fontWeight, textalign;
  Color? colors;
  var overflow;

  MyText(
      {Key? key,
      required this.title,
      this.colors,
      this.size,
      this.maxline,
      this.overflow,
      this.textalign,
      this.fontWeight,
      this.fontstyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      textAlign: textalign,
      overflow: overflow,
      maxLines: maxline,
      style: TextStyle(
          fontSize: size,
          fontStyle: fontstyle,
          color: colors,
          fontWeight: fontWeight),
    );
  }
}
