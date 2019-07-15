import 'package:coromandel_mobile/Model/ShoppingCart.dart';
import 'package:coromandel_mobile/Model/dto/ProductDetails/Modifier.dart';
import 'package:coromandel_mobile/Model/dto/ProductDetails/Topping.dart';
import 'package:flutter/material.dart';

/* AddonsRadioTileView takes care of displaying each modifier item as a
* clickable RadioTile
*
* Modifiers with CategorySelection "not required" are not displayed.
*/
class AddonsRadioTileView extends StatefulWidget {
  final Topping topping;
  final GlobalKey<ScaffoldState> scaffoldKey;

  AddonsRadioTileView(this.scaffoldKey, this.topping, {Key key})
      : super(key: key);

  @override
  _AddonsRadioTileViewState createState() => _AddonsRadioTileViewState(topping);
}

class _AddonsRadioTileViewState extends State<AddonsRadioTileView> {
  Topping topping;

  var _addonSelected;

  _AddonsRadioTileViewState(Topping topping) {
    this.topping = topping;
  }

  @override
  Widget build(BuildContext context) {
    var toppingHeader = "";
    if(topping.toppingscategoryselection !=null && topping.toppingscategoryselection == "required"){
     toppingHeader =  "${topping.toppingscategoryName} ${"(required)"}";
    }
    if(topping.toppingscategoryselection !=null && topping.toppingscategoryselection == "not required"){
      toppingHeader =  "${topping.toppingscategoryName} ${"(not required)"}";
      return new Text(""); // do not display these modifiers as RadioTiles
    }
    if(topping.toppingscategoryselection !=null && topping.toppingscategoryselection == "extras"){
      toppingHeader =  "${topping.toppingscategoryName} ${"(extras)"}";
    }
    if(topping.modifierlist == null){
    // If no modifiers, return empty
      return new Text("");
    }

    return new ListTile(
        title: Text(
            toppingHeader
        ),
        subtitle: ModifiersRadioList(topping));
  }

  Widget ModifiersRadioList(Topping topping) {
    var modifiersRadioList = List<Widget>();
    topping.modifierlist.forEach((m) {
      m.toppingCategoryId = topping.toppingscategoryId;
      modifiersRadioList.add(ModifierRadioTile(m));
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: modifiersRadioList,
    );
  }

  Widget ModifierRadioTile(Modifier modifier) {
    //TODO: Implement logic to un-select modifier
    return new RadioListTile(
      activeColor: Colors.deepOrangeAccent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            modifier.name,
            style: TextStyle(fontSize: 12.0),
          ),
          Text(
            " \$${modifier.toppingprice}",
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
      value: modifier,
      onChanged: (selectedValue) {
        ShoppingCart.instance.updateSelectedModifiers(selectedValue);
        setState(() {
          _addonSelected = selectedValue;
        });
      },
      groupValue: _addonSelected,
      selected: _addonSelected == modifier.name ? true : false,
    );
  }
}
