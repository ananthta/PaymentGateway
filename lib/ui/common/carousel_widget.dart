import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget carouselFromImages(images) {
  return new Carousel(
    images: images,
    dotSize: 5.0,
    dotSpacing: 30.0,
    dotColor: Colors.orangeAccent.shade100,
    indicatorBgPadding: 8.0,
//      borderRadius: true,
    noRadiusForIndicator: true,
    dotBgColor: Colors.transparent,
    overlayShadow: true,
//      overlayShadowColors: Colors.black,
    overlayShadowSize: 0.3,
    animationCurve: Curves.easeInOut,
    autoplayDuration: Duration(seconds: 7),
  );
}
