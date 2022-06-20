import 'package:json_annotation/json_annotation.dart';

part 'despense_type.g.dart';

@JsonSerializable()
class DespenseType {
  final int id;
  String description;
  String userId;
  bool monthFixed;
  int? iconData;
  DateTime? startDate;

  DespenseType(this.id, this.description, this.userId, this.monthFixed,
      this.iconData, this.startDate);

  factory DespenseType.fromJson(Map<String, dynamic> json) =>
      _$DespenseTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DespenseTypeToJson(this);
}
