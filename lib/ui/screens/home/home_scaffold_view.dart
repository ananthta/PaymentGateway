import 'package:coromandel_mobile/ui/common/appbar_widget.dart';
import 'package:coromandel_mobile/ui/screens/menu_category/menu_categories_grid_view.dart';
import 'package:flutter/material.dart';

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(context, "Menu"),
      drawer: null,
      body: MenuCategoriesGridView(_scaffoldKey),
      endDrawer: null,
      bottomNavigationBar: null,
    );
  }
}
