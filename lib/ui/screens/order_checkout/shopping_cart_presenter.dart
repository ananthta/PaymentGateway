import 'package:coromandel_mobile/Injection/dependency_injector.dart';
import 'package:coromandel_mobile/Model/dto/AddressVerification/AddressDto.dart';
import 'package:coromandel_mobile/Model/dto/AddressVerification/AddressVerificationResponse.dart';
import 'package:coromandel_mobile/Services/address_service.dart';
import 'package:coromandel_mobile/Services/order_service.dart';

abstract class ShoppingCartContract {
  onAddressVerificationSuccess(
      AddressVerificationResponse verificationResponse) {}

  onAddressVerificationFailure() {}
}

class ShoppingCartPresenter {
  ShoppingCartContract _view;

  OrderService _orderService;

  AddressService _addressService;

//  AddressService _addressService;

  ShoppingCartPresenter(this._view) {
//    _orderService = new Injector().provideOrderService as IOrderService;
    _addressService = new Injector().provideAddressService();
  }

  void VerifyAddress(AddressDto address) {
    //Verify Address
    _addressService
        .PostAddressVerification(address)
        .then((verificationResponse) {
      _view.onAddressVerificationSuccess(verificationResponse);
    }).catchError((error) {
      _view.onAddressVerificationFailure();
    });
  }

  void VerifyOrder() {}
}
