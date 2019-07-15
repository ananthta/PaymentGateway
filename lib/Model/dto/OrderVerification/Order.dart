//TODO: rename field names
import 'package:coromandel_mobile/Model/dto/OrderVerification/OrderItem.dart';

/* This class holds key information about items in the Shopping cart
* "orderProducts" are to be POSTed to the backend for order verification
* during checkout via toJson() method
*/
class Order {
  List<OrderProduct> orderProducts;
  double cartTotal;
  double tax;

  double tips;

  String promotioncoupon;

  double promotiondiscount;

  double deliverycharge;

  double total;

  double subTotal;

  Order() {
    cartTotal = 0.00;
    orderProducts = new List<OrderProduct>();
    deliverycharge = 0.00;
    promotioncoupon = "";
    promotiondiscount = 0.00;
    tax = 0.00;
    tips = 0.00;
    total = 0.00;
  }

  //TODO: Implement FromJson() use https://javiercbk.github.io/json_to_dart/
  /* Use this method to POST the JSON*/
  Map<String, dynamic> toJson() {
    /*TODO: convert double/int to string while posting to backend as per fields
    declared in backend*/
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderProducts != null) {
      data['product'] = this.orderProducts.map((v) => v.toJson()).toList();
    }
    data['tax'] = this.tax;
    data['tips'] = this.tips;
    data['promotioncoupon'] = this.promotioncoupon;
    data['promotiondiscount'] = this.promotiondiscount;
    data['deliverycharge'] = this.deliverycharge;
    data['total'] = this.total;
    return data;
  }
  @override
  String toString() {
    return 'Order{product: $orderProducts, tax: $tax, tips: $tips, promotioncoupon: $promotioncoupon, promotiondiscount: $promotiondiscount, deliverycharge: $deliverycharge, total: $total}';
  }
}
