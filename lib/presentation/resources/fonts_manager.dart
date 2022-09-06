import 'package:fin_task/app/constants.dart';
import 'package:fin_task/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
    String fontFamily, FontWeight fontWeight, Color color, double fontSize) {
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize);
}

TextStyle getLightTextStyle(
    {String fontFamily = AppConstants.circularStdFontFamily,
    Color color = Colors.black,
    double fontSize = FontSize.f16}) {
  return _getTextStyle(fontFamily, FontWeightManager.light, color, fontSize);
}

TextStyle getRegularTextStyle(
    {String fontFamily = AppConstants.circularStdFontFamily,
    Color color = Colors.black,
    double fontSize = FontSize.f18}) {
  return _getTextStyle(fontFamily, FontWeightManager.regular, color, fontSize);
}

TextStyle getMediumTextStyle(
    {String fontFamily = AppConstants.circularStdFontFamily,
    Color color = Colors.black,
    double fontSize = FontSize.f20}) {
  return _getTextStyle(fontFamily, FontWeightManager.medium, color, fontSize);
}

TextStyle getSemiBoldTextStyle(
    {String fontFamily = AppConstants.circularStdFontFamily,
    Color color = Colors.black,
    double fontSize = FontSize.f22}) {
  return _getTextStyle(fontFamily, FontWeightManager.semiBold, color, fontSize);
}

TextStyle getBoldTextStyle(
    {String fontFamily = AppConstants.circularStdFontFamily,
    Color color = Colors.black,
    double fontSize = FontSize.f24}) {
  return _getTextStyle(fontFamily, FontWeightManager.bold, color, fontSize);
}
