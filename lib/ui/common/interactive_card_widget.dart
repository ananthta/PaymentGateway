import 'package:flutter/material.dart';

Widget interactiveCard({Widget child, onTapAction}) {
  return GestureDetector(
      onTap: () => onTapAction,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(new Radius.circular(3.0))),
        child: child,
      ));
}
