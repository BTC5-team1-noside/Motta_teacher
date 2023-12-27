// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimetablesImpl _$$TimetablesImplFromJson(Map<String, dynamic> json) =>
    _$TimetablesImpl(
      timetableList: (json['timetableList'] as List<dynamic>)
          .map((e) => TimetableList.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjectNames: (json['subjectNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TimetablesImplToJson(_$TimetablesImpl instance) =>
    <String, dynamic>{
      'timetableList': instance.timetableList,
      'subjectNames': instance.subjectNames,
    };

_$TimetableListImpl _$$TimetableListImplFromJson(Map<String, dynamic> json) =>
    _$TimetableListImpl(
      day: json['day'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => Subjects.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TimetableListImplToJson(_$TimetableListImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'subjects': instance.subjects,
    };

_$SubjectsImpl _$$SubjectsImplFromJson(Map<String, dynamic> json) =>
    _$SubjectsImpl(
      period: json['period'] as int,
      subject_name: json['subject_name'] as String,
    );

Map<String, dynamic> _$$SubjectsImplToJson(_$SubjectsImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'subject_name': instance.subject_name,
    };
