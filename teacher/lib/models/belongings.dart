// import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import "package:riverpod_annotation/riverpod_annotation.dart";
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

@riverpod
class DayBelongingsNotifier extends _$DayBelongingsNotifier {
  @override
  DayBelongings build() {
    // 最初のデータ
    return const DayBelongings(
      isHistoryData: false,
      selectedDate: "2023-12-25",
      subjects: [
        Subject(
          period: 1,
          subject_name: "こくご",
          belongings: ["こくごのきょうかしょ", "こくごのノート", "かんじドリル"],
        ),
        Subject(
          period: 2,
          subject_name: "さんすう",
          belongings: ["さんすうのきょうかしょ", "さんすうのノート", "さんすうセット"],
        ),
        Subject(
          period: 3,
          subject_name: "たいいく",
          belongings: ["たいそうふく"],
        ),
        Subject(
          period: 4,
          subject_name: "こくご",
          belongings: ["かんじドリル", "こくごのノート", "こくごのきょうかしょ"],
        ),
      ],
      itemNames: ["ふでばこ", "はしセット", "うわばき", "エプロン"],
      additionalItemNames: [],
    );
  }

  // データを変更する関数
  void updateState(newState) {
    state = newState;
  }
}
