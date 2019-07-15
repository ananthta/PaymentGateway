import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class IRestClient {
  Future<dynamic> get(String url, {Map headers, body, encoding});

  Future<dynamic> post(String url, {Map headers, body, encoding});
}

class RestClient implements IRestClient {
  static RestClient _instance = new RestClient.internal();

  RestClient.internal();

  factory RestClient() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<dynamic> get(String url, {Map headers, body, encoding}) {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300) {
        throw new HttpException(
            'Rest API call to [$url] failed with status code: [$statusCode]\n'
            'Response Body: ${response.body}'
            'Reason Phrase: ${response.reasonPhrase}');
      }

      dynamic respBody = _decoder.convert(res);

      if (respBody == null) {
        throw new HttpException(
            'Rest API call to [$url] returned null response with status code:[$statusCode]');
      }

      return respBody;
    });
  }

  @override
  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    print('Attempting Post request to ${url}');
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300) {
        throw new HttpException(
            'Rest API call to [$url] failed with status code: [$statusCode]\n'
            'Response Body: ${response.body}'
            'Reason Phrase: ${response.reasonPhrase}');
      }

      dynamic respBody = _decoder.convert(res);
      var internalStatusCode = respBody["head"]["code"];
      if (internalStatusCode != null &&
          (internalStatusCode < 200 || internalStatusCode >= 300)) {
        throw new HttpException(
            'Rest API call to [$url] failed with status code: [$statusCode]\n'
            'Response Body: ${response.body}'
            'Reason Phrase: ${response.reasonPhrase}');
      }
      if (respBody == null) {
        throw new HttpException(
            'Rest API call to [$url] returned null response with status code:[$statusCode]');
      }

      return respBody;
    });
  }
}
