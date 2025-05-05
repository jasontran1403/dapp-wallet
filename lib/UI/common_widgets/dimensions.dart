import 'package:flutter/material.dart';

class Dimensions {
  final MediaQueryData _mediaQueryData;
  final double screenWidth;
  final double screenHeight;
  final double blockSizeHorizontal;
  final double blockSizeVertical;

  // Reference device dimensions (Pixel 9 Pro XL)
  static const double referenceScreenWidth = 412;
  static const double referenceScreenHeight = 869;

  Dimensions(BuildContext context)
      : _mediaQueryData = MediaQuery.of(context),
        screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height,
        blockSizeHorizontal = MediaQuery.of(context).size.width / 100,
        blockSizeVertical = MediaQuery.of(context).size.height / 100;

  double getWidth(double size) {
    return (size / referenceScreenWidth) * screenWidth;
  }

  double getHeight(double size) {
    return (size / referenceScreenHeight) * screenHeight;
  }

  double getFont(double size) {
    // Use minimum ratio to prevent font from becoming too big on small devices
    double widthRatio = screenWidth / referenceScreenWidth;
    double heightRatio = screenHeight / referenceScreenHeight;
    return size * (widthRatio < heightRatio ? widthRatio : heightRatio);
  }
}