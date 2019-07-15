import 'package:coromandel_mobile/Model/dto/MainMenu/CategoryGroup.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MenuCategory extends Object {
  int id;
  String type;
  String name;
  String image;
  String icon;
  String description;
  List<CategoryGroup> categoryGroups;

  MenuCategory(this.id, this.type, this.name, this.image, this.icon,
      this.description, this.categoryGroups);

  factory MenuCategory.fromJson(Map<String, dynamic> json) =>
      MenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'category_id': id,
        'category_type': type,
        'category_name': name,
        'category_image': image,
        'category_icon': icon,
        'category_description': description,
        'categorygroup': categoryGroups
      };

  @override
  String toString() {
    return 'Menucategory{category_id: $id, category_type: $type, category_name: $name, category_image: $image, category_icon: $icon, category_description: $description, categorygroup: $categoryGroups}';
  }
}

MenuCategory MenuCategoryFromJson(Map<String, dynamic> json) =>
    new MenuCategory(
        int.parse(json['category_id']),
        json['category_type'] as String,
        json['category_name'] as String,
        json['category_image'] as String,
        json['category_icon'] as String,
        json['category_description'] as String,
        (json['categorygroup'] as List)
            ?.map((e) => e == null
                ? null
                : new CategoryGroup.fromJson(e as Map<String, dynamic>))
            ?.toList());
