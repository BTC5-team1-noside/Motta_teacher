import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject_2.g.dart';

enum Subject2 {
  japanese,
  math,
  science,
  society,
  english,
}

@riverpod
class SubjectNotifier2 extends _$SubjectNotifier2 {
  @override
  Subject2 build() {
    return Subject2.japanese;
  }

  void updateSubject(Subject2 subject) {
    state = subject;
  }
}
