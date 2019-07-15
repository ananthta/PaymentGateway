import 'package:coromandel_mobile/Model/ShoppingCart.dart';
import 'package:coromandel_mobile/Model/User.dart';
import 'package:coromandel_mobile/Model/dto/AddressVerification/AddressVerificationResponse.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/Order.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/OrderItem.dart';
import 'package:coromandel_mobile/ui/common/snackbar_widgets.dart';
import 'package:coromandel_mobile/ui/screens/order_checkout/shopping_cart_presenter.dart';
import 'package:flutter/material.dart';

class ShoppingCartView extends StatefulWidget {
  Order _order;

  @override
  _CheckoutOrdersScreenState createState() => _CheckoutOrdersScreenState();

  ShoppingCartView({Key key}) : super(key: key) {
    _order = ShoppingCart.instance.orders;
  }
}

class _CheckoutOrdersScreenState extends State<ShoppingCartView>
    implements ShoppingCartContract {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ShoppingCartPresenter _presenter;
  var _tipController;

  _CheckoutOrdersScreenState() {
    _presenter = new ShoppingCartPresenter(this);
  }

  @override
  void initState() {
    ShoppingCart.instance.computeBilling();
    _tipController = TextEditingController(
        text:
            (0.25 * ShoppingCart.instance.orders.cartTotal).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    ShoppingCart.instance.computeBilling(); //TODO: remove if unnecessary
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("Checkout"),
        elevation: 0.0,
        backgroundColor: Colors.deepOrange.shade800,
      ),
      body: shoppingCartWidget(),
    );
  }

  Widget shoppingCartWidget() {
    return ListView(
      children: <Widget>[
        cartCard(),
        couponCard(),
        addressCard(),
        billingCard(),
        paymentButtonCard()
      ],
    );
  }

  Card cartCard() {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Icon(Icons.shopping_cart),
              Expanded(
                child: ListTile(
                  title: Text("Cart"),
                ),
              )
            ]),
          ),
          Container(child: cartItemsView()),
        ],
      ),
    );
  }

  Card couponCard() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                ImageIcon(new AssetImage('assets/icons/coupon_icon.png')),
                Expanded(
                  child: ListTile(
                    title: Text("Apply coupon"),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    ));
  }

  Card addressCard() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => showLocationPicker(),
              child: locationTile(),
            ),
          ),
        ],
      ),
    ));
  }

  locationTile() {
    //TODO: Re-implement entire method and controllers for text editing
    if (User.instance.address == null || User.instance.address.address1 == "") {
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          Flexible(
            child: ListTile(
              title: Text("Select address"),
            ),
          ),
          Icon(Icons.keyboard_arrow_right)
        ],
      );
    } else {
      var addressFormFields = Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "Address line 1"),
            controller: TextEditingController(
                //TODO: move to separate controller
                text: User.instance.address.address1),
            onChanged: (text) {
              setState(() {
//                User.instance.address.address1 = text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Address line 2"),
            controller: TextEditingController(
                //TODO: move to separate controller
                text: User.instance.address.address2),
            onChanged: (text) {
              setState(() {
//                User.instance.address.address2 = text;
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                decoration: InputDecoration(labelText: "City"),
                controller: TextEditingController(
                    //TODO: move to separate controller
                    text: User.instance.address.city),
                    onChanged: (text) {
                  setState(() {
//                    User.instance.address.city = text;
                  });
                },
              )),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(labelText: "Postal code"),
                controller: TextEditingController(
                    //TODO: move to separate controller
                    text: User.instance.address.zipcode),
                    onChanged: (text) {
                  setState(() {
//                    User.instance.address.zipcode = text;
                  });
                },
                keyboardType: TextInputType.numberWithOptions(),
              ))
            ],
          ),
        ],
      );

      return Column(children: <Widget>[
        Row(children: <Widget>[
          Icon(Icons.location_on),
          Flexible(
            child: ListTile(
              title: Text("Address"),
            ),
          ),
          Icon(Icons.keyboard_arrow_right)
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: addressFormFields,
        )
      ]);
    }
  }

  Card billingCard() {
//    var tipWidget = GetTipDropDownWidget();
    var tipWidget = GetTipInputWidget();
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.monetization_on),
              Expanded(
                child: ListTile(
                  title: Text("Restaurant Bill"),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tip"),
                        Flexible(child: tipWidget),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Cart total"),
                      Text("\$ ${ShoppingCart.instance.orders.cartTotal
                              .toStringAsFixed(2)}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tax"),
                      Text("\$ ${ShoppingCart.instance.orders.tax
                              .toStringAsFixed(2)}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Discount"),
                      Text("\$ ${ShoppingCart.instance.orders
                              .promotiondiscount.toStringAsFixed(2)}")
                    ], //TODO: calculate discount based on coupon chosen
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Delivery charge"),
                      Text("\$ ${ShoppingCart.instance.orders.deliverycharge
                              .toStringAsFixed(2)}")
                    ],
                  ),
                ),
                new Divider(color: Colors.blueGrey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total pay"),
                      Text(
                        "\$ ${ShoppingCart.instance.orders.total
                                .toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

//  GetTipDropDownWidget() {
//    //FIXME: Separate values of dropdown from cart prices, currently bugged
//    var tipWidget;
//
//    if (ShoppingCart.instance.orders.checkoutItems.length != 0) {
//      var tipsDropDownList =
//          GetTipsAmountList(ShoppingCart.instance.orders.cartTotal);
//      tipWidget = DropdownButton(
//          isDense: true,
//          value: _tipValue,
//          elevation: 1,
//          items: tipsDropDownList,
//          onChanged: (tipSelected) {
//            setState(() {
//              ShoppingCart.instance.orders.tips = _tipValue = tipSelected;
//            });
//          });
//    } else {
//      tipWidget = Text("\$ 0.00");
//    }
//    return tipWidget;
//  }
//
//  List<DropdownMenuItem> GetTipsAmountList(double cartTotalPrice) {
//    var tipsDropDownList = new List<DropdownMenuItem>();
//    tipsDropDownList.add(new DropdownMenuItem(
//        value: .15 * cartTotalPrice,
//        child: Text(
//          "\$${(.15 * cartTotalPrice).toStringAsFixed(2)} (15%)",
//        )));
//
//    tipsDropDownList.add(new DropdownMenuItem(
//        value: .20 * cartTotalPrice,
//        child: Text("\$${(.20 * cartTotalPrice).toStringAsFixed(2)} (20%)")));
//
//    tipsDropDownList.add(new DropdownMenuItem(
//        value: .25 * cartTotalPrice,
//        child: Text("\$${(.25 * cartTotalPrice).toStringAsFixed(2)} (25%)")));
//
//    tipsDropDownList.add(new DropdownMenuItem(
//        value: .30 * cartTotalPrice,
//        child: Text("\$${(.30 * cartTotalPrice).toStringAsFixed(2)} (30%)")));
////    tipsDropDownList.add(new DropdownMenuItem(
////        child: Text("\$${(.35 * cartTotalPrice).toStringAsFixed(2)} (35%)")));
////    tipsDropDownList.add(new DropdownMenuItem(
////        child: Text("\$${(.40 * cartTotalPrice).toStringAsFixed(2)} (40%)")));
//
//    //TODO: Implement custom tip amount input field
//    //custom tip
////    tipsDropDownList.add(new DropdownMenuItem(
////        child: Column(
////      children: <Widget>[
////        Flexible(
////          child: new TextField(
////            decoration: new InputDecoration(labelText: "Enter tip amount"),
////            keyboardType: TextInputType.number,
////          ),
////        ),
////      ],
////    )));
//
//    return tipsDropDownList;
//  }

  Card paymentButtonCard() {
    return Card(
        color: Colors.deepOrange.shade600,
        child: FlatButton(
            padding: EdgeInsets.all(16.0),
            onPressed: () {
              //TODO: Verify address
              //TODO: Verify Order
              //TODO: Proceed to payment page and gateway
              VerifyAddress();
            },
            child: Text(
              "Continue to pay",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            )));
  }

  Widget productItemTile(OrderProduct orderItem) {
    var productPriceTotal = orderItem.quantity * orderItem.price;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                padding: EdgeInsets.all(0.0),
                icon: new Icon(
                  Icons.fastfood,
                  color: Colors.deepOrange,
                )),
            Container(
              width: 190.0,
              child: Text(
                orderItem.name,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
                textScaleFactor: 0.95,
              ),
            ),
          ],
        ),
        Flexible(
          child: Row(
            children: <Widget>[
              itemQuantityPicker(orderItem),
              Text("\$" + productPriceTotal.toStringAsFixed(2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemQuantityPicker(OrderProduct orderItem) {
    return Row(
      children: <Widget>[
        new IconButton(
          padding: EdgeInsets.all(0.0),
          icon: new Icon(
            Icons.remove,
            size: 14.0,
          ),
          onPressed: () => removeFromCart(orderItem),
        ),
        new Text(
          orderItem.quantity.toInt().toString(),
          style: TextStyle(fontSize: 14.0, color: Colors.deepOrangeAccent),
        ),
        new IconButton(
            padding: EdgeInsets.all(0.0),
            icon: new Icon(
              Icons.add,
              size: 14.0,
              color: Colors.deepOrange,
            ),
            onPressed: () => addToCart(orderItem)),
      ],
    );
  }

  void addToCart(OrderProduct orderItem) {
    ShoppingCart.instance.UpdateProduct(orderItem);
    ShoppingCart.instance
        .computeBilling(); //TODO: Remove when FIXME is addressed

    setState(() {});
  }

  void removeFromCart(OrderProduct orderItem) {
    ShoppingCart.instance.removeProduct(orderItem.product_id);
    ShoppingCart.instance
        .computeBilling(); //TODO: Remove when FIXME is addressed, should not be resetting this tip value

    setState(() {});
  }

  void showLocationPicker() async {
//    LocationPicker picker = new LocationPicker();
//    var pickerAddress;
//    try {
//      pickerAddress = await picker.showLocationPicker;
//      setState(() {
//        User.instance.address.SetFromPickerAddress(pickerAddress);
//        print(pickerAddress);
//      });
//    } catch (e) {
//      //TODO: Handle error message appropriately and necessary actions if required
//      final snackBar = CustomErrorSnackBar(
//          'Something seems to be wrong with the location picker...');
//      Scaffold.of(context).showSnackBar(snackBar);
//    }
  }

  Widget cartItemsView() {
    if (ShoppingCart.instance.orders.orderProducts == null ||
        ShoppingCart.instance.orders.orderProducts.isEmpty) {
      return ListTile(
        title: Text(
          "Your cart is empty.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Please add items to continue shopping",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
//                vertical: 8.0,
              ),
              child: productItemTile(
                  ShoppingCart.instance.orders.orderProducts[index]));
        },
        itemCount: ShoppingCart.instance.orders.orderProducts.length,
        shrinkWrap: true,
        // todo comment this out and check the result
        physics:
            ClampingScrollPhysics(), // todo comment this out and check the result
      );
    }
  }

  Widget GetTipInputWidget() {
    return Container(
      width: 50.0,
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(),
        controller: _tipController,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          prefixText: "\$",
        ),
        onSubmitted: (value) {
          //TODO: validate tip value
          _tipController.clear();
          _tipController.text = "${value}";
          ShoppingCart.instance.orders.tips = double.parse(value);
        },
      ),
    );
  }

  void VerifyAddress() {
    //TODO: Verify order
    _presenter.VerifyAddress(User.instance.address);
  }

  @override
  onAddressVerificationFailure() {
    var snackBar =
        CustomErrorSnackBar('Unable to perform address verification.');
//    Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  onAddressVerificationSuccess(
      AddressVerificationResponse verificationResponse) {
    print(verificationResponse);

    if (!verificationResponse.verification) {
      final snackBar = CustomErrorSnackBar(verificationResponse.remark);
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      final snackBar =
          CustomSnackBar(verificationResponse.verification.toString());
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
