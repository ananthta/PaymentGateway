import 'package:coromandel_mobile/Services/InconsistentDataHandler.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Modifier {
  int toppingid;
  String name;
  double displaytotal;
  double toppingprice;
  String toppingdisplayprice;
  int qtyFlag;

  var toppingCategoryId;

  Modifier(
      {this.toppingid,
      this.name,
      this.displaytotal,
      this.toppingprice,
      this.toppingdisplayprice,
      this.qtyFlag});

  Modifier.fromJson(Map<String, dynamic> json) {
    toppingid = InconsistentDataHandler.ConvertToInt(json['toppingid']);
    name = json['name'];
    displaytotal =
        InconsistentDataHandler.ConvertToDouble(json['displaytotal']);
    toppingprice =
        InconsistentDataHandler.ConvertToDouble(json['toppingprice']);
    toppingdisplayprice =
        InconsistentDataHandler.ConvertToString(json['toppingdisplayprice']);
    qtyFlag = InconsistentDataHandler.ConvertToInt(json['qtyFlag']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toppingid'] = this.toppingid;
    data['name'] = this.name;
    data['displaytotal'] = this.displaytotal;
    data['toppingprice'] = this.toppingprice;
    data['toppingdisplayprice'] = this.toppingdisplayprice;
    data['qtyFlag'] = this.qtyFlag;
    return data;
  }
}
