import 'package:flutter/material.dart';

SnackBar CustomSnackBar(String text) {
  return new SnackBar(
    backgroundColor: Colors.deepOrangeAccent,
    content: new Text(
      text,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    ),
    duration: Duration(milliseconds: 1500),
  );
}

SnackBar CustomErrorSnackBar(String text) {
  return new SnackBar(
    backgroundColor: Colors.redAccent,
    content: new Text(
      text,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    ),
    duration: Duration(milliseconds: 1500),
  );
}
