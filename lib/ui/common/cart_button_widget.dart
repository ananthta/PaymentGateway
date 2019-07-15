import 'package:coromandel_mobile/Model/ShoppingCart.dart';
import 'package:coromandel_mobile/ui/screens/order_checkout/shopping_cart_items_view.dart';
import 'package:flutter/material.dart';

Widget ShoppingCartIcon(BuildContext context) {
  return new GestureDetector(
    onTap: () {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new ShoppingCartView()));
    },
    child: new Stack(
      children: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        ShoppingCart.instance.totalCartCount == 0
            ? new Container()
            : new Positioned(
                child: new Stack(
                children: <Widget>[
                  new Icon(Icons.brightness_1,
                      size: 20.0, color: Colors.deepOrange.shade900),
                  new Positioned(
                      top: 3.5,
                      right: 5.9,
                      child: new Center(
                        child: new Text(
                          ShoppingCart.instance.totalCartCount.toString(),
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              )),
      ],
    ),
  );
}
