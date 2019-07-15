import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Head extends Object {
  String msg;
  String code;

  Head(this.msg, this.code);

  factory Head.fromJson(Map<String, dynamic> json) => HeadFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{'msg': msg, 'code': code};

  @override
  String toString() {
    return 'Head{msg: $msg, code: $code}';
  }
}

Head HeadFromJson(Map<String, dynamic> json) =>
    new Head(json['msg'] as String, json['code'] as String);
