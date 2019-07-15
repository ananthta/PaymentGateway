import 'package:coromandel_mobile/Model/dto/MainMenu/MenuCategory.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MainMenu {
  int groupId;
  String groupName;
  int lunchFlag;
  int cateringFlag;
  int cateringType;
  List<MenuCategory> menuCategories;

  MainMenu(
      {this.groupId,
        this.groupName,
        this.lunchFlag,
        this.cateringFlag,
        this.cateringType,
        this.menuCategories});

  MainMenu.fromJson(Map<String, dynamic> json) {
    groupId = int.parse(json['group_id']);
    groupName = json['groupname'];
    lunchFlag = int.parse(json['lunch_flag']);
    cateringFlag = int.parse(json['catering_flag']);
    cateringType = int.parse(json['catering_type']);
    if (json['menucategory'] != null) {
      menuCategories = new List<MenuCategory>();
      json['menucategory'].forEach((v) {
        menuCategories.add(new MenuCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['groupname'] = this.groupName;
    data['lunch_flag'] = this.lunchFlag;
    data['catering_flag'] = this.cateringFlag;
    data['catering_type'] = this.cateringType;
    if (this.menuCategories != null) {
      data['menucategory'] = this.menuCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}