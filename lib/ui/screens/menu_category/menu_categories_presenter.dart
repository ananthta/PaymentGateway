import 'package:coromandel_mobile/Model/dto/MainMenu/MenuCategory.dart';
import 'package:coromandel_mobile/Services/menu_service.dart';
import 'package:coromandel_mobile/injection/dependency_injector.dart';

// Contract used by screens/menu_categories_grid_view.dart
abstract class MenuCategoriesContract {
  void onLoadMainMenuComplete(List<MenuCategory> mainMenuList);

  void onLoadMainMenuError();
}

// Presenter used by screens/menu_categories_grid_view.dart
class MenuCategoriesPresenter {
  MenuCategoriesContract _view;
  MenuService _menuService;

  MenuCategoriesPresenter(this._view) {
    _menuService = new Injector().provideMenuCategoriesRepository;
  }

  void LoadMainMenu() {
    _menuService
        .fetchMenuCategories()
        .then((menuCategories) => _view.onLoadMainMenuComplete(menuCategories))
        .catchError((e) => _view.onLoadMainMenuError());
  }
}
