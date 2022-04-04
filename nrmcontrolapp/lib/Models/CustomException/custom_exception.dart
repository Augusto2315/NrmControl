import 'package:json_annotation/json_annotation.dart';

part 'custom_exception.g.dart';

@JsonSerializable()
class CustomException implements Exception {
  final String detail;

  CustomException(this.detail);

  factory CustomException.fromJson(Map<String, dynamic> json) =>
      _$CustomExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$CustomExceptionToJson(this);
}
