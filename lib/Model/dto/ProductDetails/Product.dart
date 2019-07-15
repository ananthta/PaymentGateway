import 'package:coromandel_mobile/Model/dto/ProductDetails/Topping.dart';
import 'package:coromandel_mobile/Services/InconsistentDataHandler.dart';
import 'package:json_annotation/json_annotation.dart';

/*Product class contains information of each item available in Coromandel
It is important to note that, product model received from MainMenu response is
different from the response received from individual Product response.

Hence there are 2 different methods "Product.fromProductJson" and
"Product.fromMenuJson" used respectively in the ProductRepository and
MainMenuRepository.
*/
@JsonSerializable()
class Product {
  //Common fields
  int cateringFlag;
  int cateringType;
  int itemId;
  bool gluten;
  bool vegan;
  bool veg;
  bool spicy;
  bool verySpicy;

  //Fields from Product Response
  String productName;
  String productdDescription;
  String productImage;
  double productPrice;
  String sizeAttributes;
  String piceAttributes;
  String pastaAttributes;
  List<Topping> modifiers;

  //Fields from MainMenuResponse
  int groupId;
  int categoryId;
  int cGroupId;
  String itemName;
  String description;
  String itemImage;
  double price;

  Product(
      {this.cateringFlag,
      this.cateringType,
      this.itemId,
      this.productName,
      this.productdDescription,
      this.productImage,
      this.gluten,
      this.vegan,
      this.veg,
      this.spicy,
      this.verySpicy,
      this.productPrice,
      this.sizeAttributes,
      this.piceAttributes,
      this.pastaAttributes,
      this.modifiers});

  Product.fromProductJson(Map<String, dynamic> json) {
    cateringFlag =
        InconsistentDataHandler.ConvertToInt(json['catering_flag']) ?? 0;
    cateringType =
        InconsistentDataHandler.ConvertToInt(json['catering_type']) ?? 0;
    itemId = InconsistentDataHandler.ConvertToInt(json['item_id']);
    productName = json['productname'];
    productdDescription = json['productddescription'];
    productImage = json['productimage'];
    gluten = json['gluten'];
    vegan = json['vegan'];
    veg = json['veg'] ?? false;
    spicy = json['spicy'] ?? false;
    verySpicy = json['veryspicy'] ?? false;
    productPrice =
        InconsistentDataHandler.ConvertToDouble(json['productprice']);
    sizeAttributes = json['sizeattributes'];
    piceAttributes = json['piceattributes'];
    pastaAttributes = json['pastaattributes'];
    if (json['modifiers'] != null) {
      modifiers = new List<Topping>();
      json['modifiers'].forEach((topping) {
        modifiers.add(new Topping.fromJson(topping));
      });
    }
  }

  Map<String, dynamic> toProductJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catering_flag'] = this.cateringFlag;
    data['catering_type'] = this.cateringType;
    data['item_id'] = this.itemId;
    data['productname'] = this.productName;
    data['productddescription'] = this.productdDescription;
    data['productimage'] = this.productImage;
    data['gluten'] = this.gluten;
    data['vegan'] = this.vegan;
    data['veg'] = this.veg;
    data['spicy'] = this.spicy;
    data['veryspicy'] = this.verySpicy;
    data['productprice'] = this.productPrice;
    data['sizeattributes'] = this.sizeAttributes;
    data['piceattributes'] = this.piceAttributes;
    data['pastaattributes'] = this.pastaAttributes;
    if (this.modifiers != null) {
      data['modifiers'] = this.modifiers.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Product.FromMenuJson(Map<String, dynamic> json) {
    itemId = int.parse(json['item_id']);
    groupId = int.parse(json['group_id']);
    categoryId = int.parse(json['category_id']);
    cGroupId = int.parse(json['cgroup_id']);
    itemName = json['item_name'];
    description = json['description'];
    itemImage = json['item_image'];
    gluten = json['gluten'];
    vegan = json['vegan'];
    veg = json['veg'];
    spicy = json['spicy'];
    verySpicy = json['veryspicy'];
    price = double.parse(json['price']);
    cateringFlag = int.parse(json['catering_flag']);
    cateringType = int.parse(json['catering_type']);
  }

  Map<String, dynamic> toMenuProductJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['group_id'] = this.groupId;
    data['category_id'] = this.categoryId;
    data['cgroup_id'] = this.cGroupId;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['item_image'] = this.itemImage;
    data['gluten'] = this.gluten;
    data['vegan'] = this.vegan;
    data['veg'] = this.veg;
    data['spicy'] = this.spicy;
    data['veryspicy'] = this.verySpicy;
    data['price'] = this.price;
    data['catering_flag'] = this.cateringFlag;
    data['catering_type'] = this.cateringType;
    return data;
  }
}
