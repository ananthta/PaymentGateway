import 'package:coromandel_mobile/Model/dto/ProductDetails/Product.dart';
import 'package:coromandel_mobile/app_config.dart';
import 'package:coromandel_mobile/ui/common/appbar_widget.dart';
import 'package:coromandel_mobile/ui/common/carousel_widget.dart';
import 'package:coromandel_mobile/ui/screens/menu_items/item_card_view.dart';
import 'package:flutter/material.dart';

class MenuItemsGridView extends StatefulWidget {
  final List<Product> menuItems;
  final String categoryName;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MenuItemsGridView(this.scaffoldKey, this.menuItems, this.categoryName,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuItemsGridViewState();
}

class _MenuItemsGridViewState extends State<MenuItemsGridView> {
  List<Product> _menuItems;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _MenuItemsGridViewState();

  @override
  void initState() {
    _menuItems = widget.menuItems;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _menuItems == null || _menuItems.isEmpty
        ? LoadingIndicator()
        : new Scaffold(
            key: _scaffoldKey,
            appBar: customAppBar(context, widget.categoryName),
            body: MenuItemsWidget(),
          );
  }

  Widget MenuItemsWidget() {
    List foodImages = getFoodImages();

    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      color: Colors.white70,
      child: Column(children: [
        Expanded(
          flex: 1,
          child: carouselFromImages(foodImages),
        ),
        Expanded(
          flex: 3,
          child: MenuItemsGrid(),
        ),
      ]),
    );
  }

  GridView MenuItemsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(0.0),
      children: List.generate(_menuItems.length, (index) {
        return new ItemCardView(
            widget.scaffoldKey, index, _menuItems[index], refresh);
      }),
    );
  }

  List getFoodImages() {
    var foodImages = new List<dynamic>();
    _menuItems.forEach((item) => (){

      if(foodImages.length<8){
        if(!(item.itemImage == null || item.itemImage.isEmpty)){
          foodImages
              .add(new NetworkImage(AppConfig.BASE_URL_IMAGES + item.itemImage));
        }else if(!(item.productImage == null || item.productImage.isEmpty )){
          foodImages
              .add(new NetworkImage(AppConfig.BASE_URL_IMAGES + item.productImage));
        }
      }
    });
    return foodImages;
  }

  Widget LoadingIndicator() {
    return Center(child: new CircularProgressIndicator());
  }

  void refresh() {
    setState(() {});
  }
}
