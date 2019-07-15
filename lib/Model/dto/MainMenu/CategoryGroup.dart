import 'package:coromandel_mobile/Model/dto/ProductDetails/Product.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryGroup extends Object {
  int id;
  String name;
  List<Product> products;

  CategoryGroup(this.id, this.name, this.products);

  factory CategoryGroup.fromJson(Map<String, dynamic> json) =>
      CategoryGroupFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cgroup_id': id,
        'cgroup_name': name,
        'product': products
      };

  @override
  String toString() {
    return 'Categorygroup{cgroup_id: $id, cgroup_name: $name, product: $products}';
  }
}

CategoryGroup CategoryGroupFromJson(
        Map<String, dynamic> json) =>
    new CategoryGroup(
        int.parse(json['cgroup_id']),
        json['cgroup_name'] as String,
        (json['product'] as List)
            ?.map((e) => e == null
                ? null
                : new Product.FromMenuJson(e as Map<String, dynamic>))
            ?.toList());
