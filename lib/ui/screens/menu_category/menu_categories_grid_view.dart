import 'package:coromandel_mobile/Model/dto/MainMenu/MenuCategory.dart';
import 'package:coromandel_mobile/app_config.dart';
import 'package:coromandel_mobile/ui/common/carousel_widget.dart';
import 'package:coromandel_mobile/ui/common/snackbar_widgets.dart';
import 'package:coromandel_mobile/ui/screens/menu_category/menu_categories_presenter.dart';
import 'package:coromandel_mobile/ui/screens/menu_items/menu_items_grid_view.dart';
import 'package:flutter/material.dart';

class MenuCategoriesGridView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  MenuCategoriesGridView(this.scaffoldKey, {Key key}) : super(key: key);

  @override
  _MenuCategoriesGridViewState createState() => _MenuCategoriesGridViewState();
}

class _MenuCategoriesGridViewState extends State<MenuCategoriesGridView>
    implements MenuCategoriesContract {
  MenuCategoriesPresenter _presenter;
  bool _isLoading;
  List<MenuCategory> _menuCategories;

  _MenuCategoriesGridViewState() {
    _presenter = new MenuCategoriesPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    _presenter.LoadMainMenu();
  }

  @override
  Widget build(BuildContext context) {
    return _menuCategories == null || _menuCategories.isEmpty
        ? LoadingIndicator()
        : new Container(child: MenuCategoriesWidget());
  }

  Widget MenuCategoriesWidget() {
    List<AssetImage> restaurantImages = getRestaurantImages();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(children: [
        Expanded(
          flex: 1,
          child: carouselFromImages(restaurantImages),
        ),
        Expanded(
          flex: 3,
          child: MenuCategoriesGrid(),
        )
      ]),
    );
  }

  GridView MenuCategoriesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(0.0),
      children: List.generate(_menuCategories.length, (index) {
        return MenuCategoryGridTile(index);
      }),
    );
  }

  Widget MenuCategoryGridTile(int index) {
    return GestureDetector(
      onTap: () => GoToMenuItemsPage(index),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(new Radius.circular(3.0))),
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/default_food_image.jpg',
                image: AppConfig.BASE_URL_IMAGES + _menuCategories[index].image,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    _menuCategories[index].name.toUpperCase(),
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
            ),
            //Category name
          ],
        ),
      ),
    );
  }

  List<AssetImage> getRestaurantImages() {
    var restaurantImages = [
      new AssetImage('assets/images/carousel_gallery_1.jpg'),
      new AssetImage('assets/images/carousel_gallery_2.jpg'),
      new AssetImage('assets/images/carousel_gallery_3.jpg'),
      new AssetImage('assets/images/carousel_gallery_4.jpg'),
      new AssetImage('assets/images/carousel_gallery_5.jpg'),
    ];
    return restaurantImages;
  }

  Widget LoadingIndicator() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  void onLoadMainMenuComplete(List<MenuCategory> menuCategories) {
    _isLoading = false;
    setState(() {
      _menuCategories = menuCategories;
    });
  }

  @override
  void onLoadMainMenuError() {
    //TODO: Handle error message appropriately and necessary actions if required
    final snackBar = CustomErrorSnackBar('Error loading Main Menu');
    Scaffold.of(context).showSnackBar(snackBar);
  }

  GoToMenuItemsPage(int index) {
    var menuItems = _menuCategories[index].categoryGroups.first.products;

    var category = _menuCategories[index].name;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MenuItemsGridView(widget.scaffoldKey,
                menuItems, category = _menuCategories[index].name)));
  }
}
