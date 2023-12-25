// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'belongings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DayBelongingsImpl _$$DayBelongingsImplFromJson(Map<String, dynamic> json) =>
    _$DayBelongingsImpl(
      selectedDate: json['selectedDate'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemNames:
          (json['itemNames'] as List<dynamic>).map((e) => e as String).toList(),
      additionalItemNames: (json['additionalItemNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$DayBelongingsImplToJson(_$DayBelongingsImpl instance) =>
    <String, dynamic>{
      'selectedDate': instance.selectedDate,
      'subjects': instance.subjects,
      'itemNames': instance.itemNames,
      'additionalItemNames': instance.additionalItemNames,
    };

_$SubjectImpl _$$SubjectImplFromJson(Map<String, dynamic> json) =>
    _$SubjectImpl(
      period: json['period'] as int,
      subject_name: json['subject_name'] as String,
      belongings: (json['belongings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SubjectImplToJson(_$SubjectImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'subject_name': instance.subject_name,
      'belongings': instance.belongings,
    };
