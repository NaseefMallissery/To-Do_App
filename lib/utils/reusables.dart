import 'package:flutter/material.dart';
import 'package:graphql_todo/utils/constants.dart';
// import 'package:screen_utils/screen_utils.dart';

Text text({
  required String content,
  Color? color,
  double? size = 15,
  String? fontFamily,
  FontWeight? fontWeight = FontWeight.w400,
  TextOverflow? overflow = TextOverflow.ellipsis,
  int? maxLines = 1,
  bool lineThrough=false,
}) {
  return Text(
    content,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      decoration:
      lineThrough==false?
      TextDecoration.none
      :
       TextDecoration.lineThrough,
    ),
  );
}

Icon icon({
  required IconData iconData,
  Color? color = AppColors.whiteColor,
  double? size = 20,
}) {
  return Icon(
    iconData,
    color: color,
    size: size,
  );
}

Container customContainer({
  required Widget child,
  double? height,
  double? width,
  Color? color = Colors.white,
  List<BoxShadow>? boxShadow,
  BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(
      15,
    ),
  ),
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      color: color,
      boxShadow: boxShadow,
    ),
    child: child,
  );
}
