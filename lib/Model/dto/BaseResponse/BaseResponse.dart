import 'package:coromandel_mobile/Model/dto/BaseResponse/Body.dart';
import 'package:coromandel_mobile/Model/dto/BaseResponse/Head.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse extends Object {
  Head head;
  Body body;

  BaseResponse(this.head, this.body);

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      BaseResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'head': head, 'body': body};

  @override
  String toString() {
    return 'RootObject{head: $head, body: $body}';
  }
}

BaseResponse BaseResponseFromJson(Map<String, dynamic> json) =>
    new BaseResponse(
        json['head'] == null
            ? null
            : new Head.fromJson(json['head'] as Map<String, dynamic>),
        json['body'] == null
            ? null
            : new Body.fromJson(json['body'] as Map<String, dynamic>));
