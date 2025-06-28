import 'package:flutter/material.dart';

double sizeOfWidth({required double size}) {
  return (globalWidth * size) / percentage;
}

double sizeOfHeight({required double size}) {
  return (globalHeight * size) / percentage;
}

double sizeOfReturnValue({required double size,bool isWidth = false,bool isHeight = false}) {

  if (isHeight){
    return sizeOfHeight(size: calculateSize(size));
  }
  else{
    return sizeOfWidth(size: calculateSize(size));
  }
 }

Widget addVerticalSpace({required double height}){
  return SizedBox(height: sizeOfHeight(size: calculateSize(height)));
}

Widget addHorizontalSpace({required double width}){
  return SizedBox(width: sizeOfHeight(size: calculateSize(width)));
}

double calculateSize(double size) {
  return (size * percentage) / globalWidth;
}

late double globalHeight;
late double globalWidth;
int percentage = 100;