import 'package:json_annotation/json_annotation.dart';

part 'despense_type.g.dart';

@JsonSerializable()
class DespenseType {
  final int id;
  final String description;
  final String userId;
  bool monthFixed;
  final DateTime? startDate;

  DespenseType(
      this.id, this.description, this.userId, this.monthFixed, this.startDate);

  factory DespenseType.fromJson(Map<String, dynamic> json) =>
      _$DespenseTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DespenseTypeToJson(this);
}
