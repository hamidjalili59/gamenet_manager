import 'package:flutter/material.dart';

import 'enums.dart';

class AppTheme {
  /// general Theme Attribute
  static const borderRadius = 16.0;
  static const defaultPadding = 16.0;
  static const Size designSize = Size(360, 690);
  static const Size designSizeDesktop = Size(900, 1600);

  ///Colors
  Color white = const Color(0xFFFFFFFF);
  static const deepBlue = Color(0xff020227);
  static const cyan = Color(0xff34FBD0);
  static const darkGrey = Color(0xff2a2747);
  static const liteBlue = Color(0xff3acaf5);
  static const backgroundColor = Color(0xff121212);

  ///Gradients
  static const List<Color> liteBlueGradient = [
    Color(0xffcb2d3e),
    Color(0xffef473a),
  ];
  static const List<Color> darkBlueGradient = [Color(0xff226089), Color(0xff4592af)];

  //Font names
  static const sgkaraFont = 'sgkara';
  static const iransansFont = 'IRANSans';

  static TextStyle fontCreator({
    double fontSize = 14.0,
    FontWeights fontWeights = FontWeights.regular,
    Color fontColor = Colors.white,
    String fontName = iransansFont,
    double? lineHeight,
    List<Shadow>? shadow,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: fontColor,
      fontFamily: fontName,
      height: lineHeight,
      shadows: shadow,
      fontWeight: fontWeights == FontWeights.ultraLight
          ? FontWeight.w200
          : fontWeights == FontWeights.light
              ? FontWeight.w300
              : fontWeights == FontWeights.regular
                  ? FontWeight.w400
                  : fontWeights == FontWeights.medium
                      ? FontWeight.w500
                      : fontWeights == FontWeights.bold
                          ? FontWeight.w700
                          : FontWeight.w400,
    );
  }
}
