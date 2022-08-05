// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'despense_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DespenseType _$DespenseTypeFromJson(Map<String, dynamic> json) => DespenseType(
      json['id'] as int,
      json['description'] as String,
      json['userId'] as String,
      json['monthFixed'] as bool,
      json['iconData'] as int?,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DespenseTypeToJson(DespenseType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'userId': instance.userId,
      'monthFixed': instance.monthFixed,
      'iconData': instance.iconData,
      'startDate': instance.startDate?.toIso8601String(),
      'value': instance.value,
    };
