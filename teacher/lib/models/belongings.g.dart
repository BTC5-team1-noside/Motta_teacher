// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'belongings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DayBelongingsImpl _$$DayBelongingsImplFromJson(Map<String, dynamic> json) =>
    _$DayBelongingsImpl(
      isHistoryData: json['isHistoryData'] as bool,
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
      'isHistoryData': instance.isHistoryData,
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

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dayBelongingsNotifierHash() =>
    r'6e25cb1a4add04c9bcfd29c5a16caf47e8e98c0d';

/// See also [DayBelongingsNotifier].
@ProviderFor(DayBelongingsNotifier)
final dayBelongingsNotifierProvider =
    AutoDisposeNotifierProvider<DayBelongingsNotifier, DayBelongings>.internal(
  DayBelongingsNotifier.new,
  name: r'dayBelongingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dayBelongingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DayBelongingsNotifier = AutoDisposeNotifier<DayBelongings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
