import 'package:coromandel_mobile/ui/common/cart_button_widget.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title) {
  return new AppBar(
      title: new Text(
          '${title[0].toUpperCase()}${title.substring(1).toLowerCase()}'),
      elevation: 0.0,
      backgroundColor: Colors.deepOrange.shade800,
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
              height: 150.0, width: 30.0, child: ShoppingCartIcon(context)),
        )
      ]);
}
