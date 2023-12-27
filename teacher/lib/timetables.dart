// import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'timetables.freezed.dart';
part 'timetables.g.dart';

@freezed
class Timetables with _$Timetables {
  const factory Timetables({
    required List<TimetableList> timetableList,
    required List<String> subjectNames,
  }) = _Timetables;

  factory Timetables.fromJson(Map<String, dynamic> json) =>
      _$TimetablesFromJson(json);
}

@freezed
class TimetableList with _$TimetableList {
  const factory TimetableList({
    required String day,
    required List<Subjects> subjects,
  }) = _TimetableList;

  factory TimetableList.fromJson(Map<String, dynamic> json) =>
      _$TimetableListFromJson(json);
}

@freezed
class Subjects with _$Subjects {
  const factory Subjects({
    required int period,
    required String subject_name,
  }) = _Subjects;

  factory Subjects.fromJson(Map<String, dynamic> json) =>
      _$SubjectsFromJson(json);
}
