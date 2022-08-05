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
  double? value;

  DespenseType(this.id, this.description, this.userId, this.monthFixed,
      this.iconData, this.startDate, this.value);

  factory DespenseType.fromJson(Map<String, dynamic> json) =>
      _$DespenseTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DespenseTypeToJson(this);

  @override
  String toString() {
    return "id: $id - description: $description - userId: $userId - monthFixed: $monthFixed - iconData: $iconData - startDate: $startDate - value $value";
  }
}
