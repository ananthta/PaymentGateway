import 'package:flutter/material.dart';

Widget expandedRowWidget(
    {@required List<Widget> rowChildren,
    EdgeInsetsGeometry padding,
    MainAxisSize mainAxisSize,
    VerticalDirection verticalDirection,
    TextBaseline textBaseline,
    TextDirection textDirection,
    Key rowKey,
    CrossAxisAlignment crossAxisAlignment,
    MainAxisAlignment mainAxisAlignment}) {
  return Expanded(
    child: Padding(
      padding: padding ?? EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        verticalDirection: verticalDirection ?? VerticalDirection.down,
        textBaseline: textBaseline ?? TextBaseline.alphabetic,
        textDirection: textDirection ?? TextDirection.ltr,
        key: rowKey,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.end,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: rowChildren,
      ),
    ),
  );
}

Widget expandedPaddedColumnWidget(
    {@required List<Widget> columnChildren,
    EdgeInsetsGeometry padding,
    MainAxisSize mainAxisSize,
    VerticalDirection verticalDirection,
    TextBaseline textBaseline,
    TextDirection textDirection,
    Key rowKey,
    CrossAxisAlignment crossAxisAlignment,
    MainAxisAlignment mainAxisAlignment}) {
  return Expanded(
    child: Padding(
      padding: padding ?? EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        verticalDirection: verticalDirection ?? VerticalDirection.down,
        textBaseline: textBaseline ?? TextBaseline.alphabetic,
        textDirection: textDirection ?? TextDirection.ltr,
        key: rowKey,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
        children: columnChildren,
      ),
    ),
  );
}
