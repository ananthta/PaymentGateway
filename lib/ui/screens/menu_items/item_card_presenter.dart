import 'package:coromandel_mobile/Model/dto/ProductDetails/Product.dart';
import 'package:coromandel_mobile/Services/product_service.dart';
import 'package:coromandel_mobile/injection/dependency_injector.dart';

abstract class ItemCardContract {
  void onFetchItemComplete(Product product);

  void onFetchItemError();
}

class ItemCardPresenter {
  ItemCardContract _view;

  ProductService _productService;

  ItemCardPresenter(this._view) {
    _productService = new Injector().provideProductRepository();
  }

  void FetchItemDetails(int productId) {
    _productService
        .fetchProductDetails(productId)
        .then((product) => _view.onFetchItemComplete(product))
        .catchError((error) => _view.onFetchItemError());
  }
}
