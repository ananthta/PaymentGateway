import 'package:coromandel_mobile/Model/dto/ProductDetails/Modifier.dart';
import 'package:coromandel_mobile/Services/InconsistentDataHandler.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Topping {
  int toppingscategoryId;
  String toppingscategoryName;
  String toppingscategorytype;
  String toppingscategoryselection;
  String toppingscategoryordertext;
  int maximumselection;
  int maximumqty;
  int maximumpriceFlag;
  String toppingType;
  List<Modifier> modifierlist;

  Topping(
      {this.toppingscategoryId,
      this.toppingscategoryName,
      this.toppingscategorytype,
      this.toppingscategoryselection,
      this.toppingscategoryordertext,
      this.maximumselection,
      this.maximumqty,
      this.maximumpriceFlag,
      this.toppingType,
      this.modifierlist});

  Topping.fromJson(Map<String, dynamic> json) {
    toppingscategoryId =
        InconsistentDataHandler.ConvertToInt(json['toppingscategory_id']);

    toppingscategoryName = json['toppingscategory_name'];
    toppingscategorytype = json['toppingscategorytype'];
    toppingscategoryselection = json['toppingscategoryselection'];
    toppingscategoryordertext = json['toppingscategoryordertext'];

    maximumselection =
        InconsistentDataHandler.ConvertToInt(json['Maximumselection']) ?? 0;

    maximumqty = InconsistentDataHandler.ConvertToInt(json['Maximumqty']) ?? 0;

    maximumpriceFlag =
        InconsistentDataHandler.ConvertToInt(json['MaximumpriceFlag']) ?? 0;

    toppingType = json['topping_type'];
    if (json['modifierlist'] != null) {
      modifierlist = new List<Modifier>();
      json['modifierlist'].forEach((v) {
        modifierlist.add(new Modifier.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toppingscategory_id'] = this.toppingscategoryId;
    data['toppingscategory_name'] = this.toppingscategoryName;
    data['toppingscategorytype'] = this.toppingscategorytype;
    data['toppingscategoryselection'] = this.toppingscategoryselection;
    data['toppingscategoryordertext'] = this.toppingscategoryordertext;
    data['Maximumselection'] = this.maximumselection;
    data['Maximumqty'] = this.maximumqty;
    data['MaximumpriceFlag'] = this.maximumpriceFlag;
    data['topping_type'] = this.toppingType;
    if (this.modifierlist != null) {
      data['modifierlist'] = this.modifierlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
