import 'package:coromandel_mobile/Model/ShoppingCart.dart';
import 'package:coromandel_mobile/Model/dto/ProductDetails/Product.dart';
import 'package:coromandel_mobile/app_config.dart';
import 'package:coromandel_mobile/ui/common/conditional_widget.dart';
import 'package:coromandel_mobile/ui/common/expanded_padded_widget.dart';
import 'package:coromandel_mobile/ui/common/interactive_card_widget.dart';
import 'package:coromandel_mobile/ui/common/snackbar_widgets.dart';
import 'package:coromandel_mobile/ui/screens/menu_items/addons_radio_tile_view.dart';
import 'package:coromandel_mobile/ui/screens/menu_items/item_card_presenter.dart';
import 'package:flutter/material.dart';

class ItemCardView extends StatefulWidget {
  final index;
  final item;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Function refreshMenuItemsGrid;

  ItemCardView(
      this.scaffoldKey, this.index, this.item, this.refreshMenuItemsGrid,
      {Key key})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState(item);
}

class _ItemCardState extends State<ItemCardView> implements ItemCardContract {
  ItemCardPresenter _itemCardPresenter;
  bool isLoaded = false;

  Product _product;
  int _itemQuantity = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _ItemCardState(this._product) {
    _itemCardPresenter = new ItemCardPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //todo: create utility boolean method to check if product exists in cart or not
    if (ShoppingCart.instance.orders.orderProducts != null) {
      var existingProduct = ShoppingCart.instance.orders.orderProducts
          .where((p) => p.product_id == _product.itemId)
          .toList();

      if (existingProduct != null && existingProduct.isNotEmpty) {
        _itemQuantity = existingProduct.first.quantity.toInt();
      }
    }

    return new Container(
        child:
            interactiveCard(child: getItemWidget(), onTapAction: gotoItemDetails()));
  }

  getItemWidget(){
    return Column(
      children: <Widget>[
        getItemImage(),
        getItemNameRow(),
        expandedRowWidget(
            rowChildren: <Widget>[getItemPrice(), addItemButtonOrPicker],
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end),
        //Category name
      ],
    );
  }

  getItemImage(){
    var image = "";
    if(!(_product.productImage == null || _product.productImage.isEmpty)){
      image = AppConfig.BASE_URL_IMAGES + _product.productImage;
    }
    if(!(_product.itemImage == null || _product.itemImage.isEmpty)){
      image = AppConfig.BASE_URL_IMAGES + _product.itemImage;
    }
    return Expanded(
        flex: 5,
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: 'assets/images/default_food_image.jpg',
          image: image,
        ));
  }

  /* Item Name Row Text */
  getItemNameRow(){
    var productName = "";
    if(!(_product.productName ==null || _product.productName.isEmpty)){
      productName = _product.productName;
    }
    if(!(_product.itemName ==null || _product.itemName.isEmpty)){
      productName = _product.itemName;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Text(
              productName,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  /* Item Price Text */
  getItemPrice(){
    var price;
    if(!(_product.productPrice == null)){
      price = _product.productPrice;
    }
    if(!(_product.price == null)){
      price = _product.price;
    }

    return new Text(
      "\$ " + price.toString(),
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
    );

  }

  //If no existing products, show add button, else show item picker
  get addItemButtonOrPicker => conditionalWidget(
      _itemQuantity == 0, addItemSizedButton, itemQuantityPicker);

  // Add Button for product that is not in cart already
  get addItemSizedButton => SizedBox(
        width: 60.0,
        height: 20.0,
        child: new FlatButton(
          shape: RoundedRectangleBorder(),
          child: const Text(
            'ADD',
            style: TextStyle(fontSize: 14.0, color: Colors.deepOrange),
          ),
          splashColor: Colors.blueGrey,
          onPressed: () {
            isLoaded = false;
            _itemCardPresenter.FetchItemDetails(_product.itemId);
          },
        ),
      );

  //Quantity picker for products that are already existing in cart
  get itemQuantityPicker => Row(
        children: <Widget>[
          new IconButton(
            padding: EdgeInsets.all(0.0),
            icon: new Icon(
              Icons.remove,
              size: 14.0,
            ),
            onPressed: removeFromCart,
          ),
          new Text(
            _itemQuantity.toString(),
            style: TextStyle(fontSize: 14.0, color: Colors.deepOrange),
          ),
          new IconButton(
              color: Colors.deepOrange,
              padding: EdgeInsets.all(0.0),
              icon: new Icon(
                Icons.add,
                size: 14.0,
              ),
              onPressed: addToCart),
        ],
      );

  void addToCart() {
    ShoppingCart.instance.addNewProduct(_product);

    setState(() {
      _itemQuantity++;
    });
    widget.refreshMenuItemsGrid();
  }

  void removeFromCart() {
    ShoppingCart.instance.removeProduct(_product.itemId);

    setState(() => _itemQuantity = _itemQuantity - 1);
    widget.refreshMenuItemsGrid();
  }

  @override
  void onFetchItemComplete(Product product) {
    _product = product;
    if (product.modifiers != null) {
      showAddonsSelectionModal();
    } else {
      //TODO: Add product to order here
      ShoppingCart.instance.addNewProduct(_product);
      setState(() {
        _itemQuantity++;
      });
    }
    widget.refreshMenuItemsGrid();
  }

  //TODO: Make ToppingModal a new Stateful class
  void showAddonsSelectionModal() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return addonsModal();
        });
  }

  Widget addonsModal() {
    final addonsListView = ListView.builder(
      itemBuilder: (BuildContext context, int index) => new AddonsRadioTileView(
            widget.scaffoldKey,
            _product.modifiers[index],
          ),
      itemCount: _product.modifiers?.length,
    );

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            _product.productName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        new Divider(color: Colors.blueGrey),
        Flexible(
          child: addonsListView,
        ),
        new Divider(color: Colors.blueGrey),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Item Price  |  \$${_product.productPrice}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //TODO: Add toppings price to the product price
              FlatButton(
                  onPressed: () {
                    ShoppingCart.instance.addNewProduct(_product);
                    Scaffold.of(context).showSnackBar(
                        CustomSnackBar("Added ${_product.productName} to your cart."));
                    Navigator.pop(context); //Dismiss the ToppingsModifier Modal
                    setState(() {
                      _itemQuantity++;
                    });
                    widget.refreshMenuItemsGrid();
                  },
                  child: Text(
                    "Add Item",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16.0),
                  ))
            ],
          ),
        )
      ],
    );
  }

  //Loading bar
  Widget loadingIndicator() {
    return Center(child: new CircularProgressIndicator());
  }

  gotoItemDetails() {
    //TODO: Push to Product Details page
  }

  @override
  void onFetchItemError() {
    //TODO: Handle error message appropriately and necessary actions if required
    final snackBar = CustomErrorSnackBar('Error loading Product');
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
