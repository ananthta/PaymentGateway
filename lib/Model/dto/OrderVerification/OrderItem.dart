import 'package:coromandel_mobile/Model/dto/OrderVerification/ModifierOrder.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/Order.dart';

class OrderProduct {
  int product_id;
  String name;
  double price;
  double quantity;

  String sizeattributes_id;

  String sizeattributes_value_id;

  String piceattribute_id;

  String piceattribute_value_id;

  String pastaattribute_id;

  String pastaattribute_value_id;

  List<ModifierOrder> modifierOrders;

  OrderProduct(
      this.name,
      this.price,
      this.product_id,
      this.quantity,
      this.sizeattributes_id,
      this.sizeattributes_value_id,
      this.piceattribute_id,
      this.piceattribute_value_id,
      this.pastaattribute_id,
      this.pastaattribute_value_id,
      this.modifierOrders);

  Map<String, dynamic> toJson() {
    /*TODO: convert double/int to string while posting to backend as per fields
      declared in backend*/
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['quantity'] = this.quantity;
    data['sizeattributes_id'] = this.sizeattributes_id;
    data['sizeattributes_value_id'] = this.sizeattributes_value_id;
    data['piceattribute_id'] = this.price;
    data['piceattribute_value_id'] = this.piceattribute_value_id;
    data['pastaattribute_id'] = this.pastaattribute_id;
    data['pastaattribute_value_id'] = this.pastaattribute_value_id;
    if (this.modifierOrders != null) {
      data['modifier'] = this.modifierOrders.map((v) => v.toJson()).toList();
    }
    return data;
  }

  //TODO: Implement FromJson() use https://javiercbk.github.io/json_to_dart/
  @override
  String toString() {
    return 'OrderItem{product_id: $product_id,name:$name, quantity: $quantity, sizeattributes_id: $sizeattributes_id, sizeattributes_value_id: $sizeattributes_value_id, piceattribute_id: $piceattribute_id, piceattribute_value_id: $piceattribute_value_id, pastaattribute_id: $pastaattribute_id, pastaattribute_value_id: $pastaattribute_value_id, modifier: $modifierOrders}';
  }
}
