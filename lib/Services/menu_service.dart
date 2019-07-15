import 'dart:async';

import 'package:coromandel_mobile/Model/dto/BaseResponse/BaseResponse.dart';
import 'package:coromandel_mobile/Model/dto/MainMenu/MenuCategory.dart';
import 'package:coromandel_mobile/Utils/rest_client.dart';
import 'package:coromandel_mobile/app_config.dart';
import 'package:coromandel_mobile/injection/dependency_injector.dart';

abstract class IMainMenuService {
  Future<List<MenuCategory>> fetchMenuCategories();
}

class MenuService implements IMainMenuService {
  final String mainMenuUrl = AppConfig.BASE_URL + "mainmenu";
  final RestClient _restClient = new Injector().provideRestClient as RestClient;

  @override
  Future<List<MenuCategory>> fetchMenuCategories() async {
    try {
      var jsonResponse = await _restClient.get(mainMenuUrl);
      BaseResponse menuResponse = new BaseResponse.fromJson(jsonResponse);
      return menuResponse.body.mainMenu.first.menuCategories;
    } catch (e) {
      print('Error fetching Menu Categories Json: ${e.toString()}');
      return [];
    }
  }
}
