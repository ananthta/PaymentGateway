class ModifierOrder {
  int toppingscategory_id;

  int toppings_id;

  double toppings_price;

  ModifierOrder(
      this.toppingscategory_id, this.toppings_id, this.toppings_price);

  Map<String, dynamic> toJson() {
    /*TODO: convert double/int to string while posting to backend as per fields
    declared in backend*/
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toppingscategory_id'] = this.toppingscategory_id;
    data['toppings_id'] = this.toppings_id;
    data['toppings_price'] = this.toppings_price;
    return data;
  }
  //TODO: Implement FromJson()
  @override
  String toString() {
    return 'Modifier{toppingscategory_id: $toppingscategory_id, toppings_id: $toppings_id, toppings_price: $toppings_price}';
  }
}