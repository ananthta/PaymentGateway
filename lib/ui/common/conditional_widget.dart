import 'package:flutter/material.dart';

Widget conditionalWidget(
    bool condition, Widget widgetWhenTrue, Widget widgetWhenFalse) {
  return condition ? widgetWhenTrue : widgetWhenFalse;
}
