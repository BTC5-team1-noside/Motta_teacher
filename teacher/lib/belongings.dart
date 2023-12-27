// import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'belongings.freezed.dart';
part 'belongings.g.dart';

@freezed
class DayBelongings with _$DayBelongings {
  const factory DayBelongings({
    required bool isHistoryData,
    required String selectedDate,
    required List<Subject> subjects,
    required List<String> itemNames,
    required List<String> additionalItemNames,
  }) = _DayBelongings;

  factory DayBelongings.fromJson(Map<String, dynamic> json) =>
      _$DayBelongingsFromJson(json);
}

@freezed
class Subject with _$Subject {
  const factory Subject({
    required int period,
    required String subject_name,
    required List<String> belongings,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
