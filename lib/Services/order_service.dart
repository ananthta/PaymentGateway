import 'dart:async';

import 'package:coromandel_mobile/Injection/dependency_injector.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/Order.dart';
import 'package:coromandel_mobile/Utils/rest_client.dart';

abstract class IOrderService {
  Future<dynamic> PostOrder(Order order) async {}
}

class OrderService implements IOrderService {
  final RestClient _restClient = new Injector().provideRestClient as RestClient;

  @override
  Future PostOrder(Order order) async {
    // TODO: implement PostOrder
  }
}
