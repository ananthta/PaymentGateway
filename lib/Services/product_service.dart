import 'dart:async';

import 'package:coromandel_mobile/Model/dto/ProductDetails/Product.dart';
import 'package:coromandel_mobile/Utils/rest_client.dart';
import 'package:coromandel_mobile/app_config.dart';
import 'package:coromandel_mobile/injection/dependency_injector.dart';

abstract class IProductService {
  Future<Product> fetchProductDetails(int productId);
}

class ProductService implements IProductService {
  final String ProductDetailsUrl = AppConfig.BASE_URL + "singleproduct.php";
  final RestClient _restClient = new Injector().provideRestClient as RestClient;

  @override
  Future<Product> fetchProductDetails(int productId) async {
    try {
      print('Fetching Product Details');
      var requestJson = "{\"pid\":\"${productId}\"}";
      var jsonResponse =
          await _restClient.post(ProductDetailsUrl, body: requestJson);
      print(jsonResponse);
      Product product = new Product.fromProductJson(jsonResponse['body']);
      print('Successfully Fetched Product Details ${product.toString()}');
      return product;
    return null;
    } catch (e) {
      print('Error fetching Product Json: ${e.
      toString()}');
      return null;
    }
  }
}
