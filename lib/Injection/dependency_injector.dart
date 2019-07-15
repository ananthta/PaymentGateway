import 'package:coromandel_mobile/Services/address_service.dart';
import 'package:coromandel_mobile/Services/menu_service.dart';
import 'package:coromandel_mobile/Services/order_service.dart';
import 'package:coromandel_mobile/Services/product_service.dart';
import 'package:coromandel_mobile/Utils/rest_client.dart';

enum Flavor { MOCK, PROD, STAGE, DEV }

// Injector class can be used to provide real objects for application
// or mocked objects for test cases depending on flavour configured.
class Injector {
  static final Injector _singleton = new Injector._internal();

  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  static Flavor getFlavor() {
    return _flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  IRestClient get provideRestClient {
    switch (_flavor) {
      case Flavor.DEV:
        return new RestClient();

      default:
        return new RestClient();
    }
  }

  IMainMenuService get provideMenuCategoriesRepository {
    switch (_flavor) {
      case Flavor.DEV:
        return new MenuService();

      default:
        return new MenuService();
    }
  }

  IProductService provideProductRepository() {
    switch (_flavor) {
      case Flavor.DEV:
        return new ProductService();

      default:
        return new ProductService();
    }
  }

  IOrderService provideOrderService() {
    switch (_flavor) {
      case Flavor.DEV:
        return new OrderService();

      default:
        return new OrderService();
    }
  }

  AddressService provideAddressService() {
    switch (_flavor) {
      case Flavor.DEV:
        return new AddressService();

      default:
        return new AddressService();
    }
  }
}
