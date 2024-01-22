import 'package:flutter/material.dart';

extension LayoutExtension on Widget {
  Widget size({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Widget center() => Center(child: this);

  Widget scrollable({scrollDirection = Axis.vertical}) => SingleChildScrollView(
        scrollDirection: scrollDirection,
        child: this,
      );
}
