import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:coromandel_mobile/Injection/dependency_injector.dart';
import 'package:coromandel_mobile/Model/dto/AddressVerification/AddressDto.dart';
import 'package:coromandel_mobile/Model/dto/AddressVerification/AddressVerificationResponse.dart';
import 'package:coromandel_mobile/Utils/rest_client.dart';
import 'package:coromandel_mobile/app_config.dart';

abstract class IAddressService {
  Future<AddressVerificationResponse> PostAddressVerification(
      AddressDto addressSelected) async {}
}

class AddressService implements IAddressService {
  final String addressVerificationUrl =
      AppConfig.BASE_URL + "addressverification.php";
  final RestClient _restClient = new Injector().provideRestClient as RestClient;

  @override
  Future<AddressVerificationResponse> PostAddressVerification(
      AddressDto addressSelected) async {
    try {
      if (addressSelected
          .address2.isEmpty) //TODO: Remove hardcoded workaround for address 2
        addressSelected.address2 = addressSelected.address1;

      var jsonResponse = await _restClient.post(addressVerificationUrl,
          body: new JsonEncoder().convert(addressSelected));

      AddressVerificationResponse addressVerificationResponse =
          new AddressVerificationResponse().fromJson(jsonResponse["body"]);
      return addressVerificationResponse;
    } catch (e) {
      print('Error fetching Menu Categories Json: ${e.toString()}');
      throw new HttpException(e.message);
    }
  }
}
