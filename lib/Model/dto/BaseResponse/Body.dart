import 'package:coromandel_mobile/Model/dto/MainMenu/MainMenu.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Body extends Object {
  List<MainMenu> mainMenu;

  Body(this.mainMenu);

  factory Body.fromJson(Map<String, dynamic> json) => BodyFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{'mainmenu': mainMenu};

  @override
  String toString() {
    return 'Body{mainmenu: $mainMenu}';
  }
}

Body BodyFromJson(Map<String, dynamic> json) =>
    new Body((json['mainmenu'] as List)
        ?.map((e) =>
            e == null ? null : new MainMenu.fromJson(e as Map<String, dynamic>))
        ?.toList());
