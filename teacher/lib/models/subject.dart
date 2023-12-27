import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject.g.dart';

enum Subject1 {
  japanese,
  math,
  science,
  society,
  english,
}

@riverpod
class Subject1Notifier extends _$Subject1Notifier {
  @override
  Subject1 build() {
    return Subject1.japanese;
  }

  void updateSubject(Subject1 subject) {
    state = subject;
  }
}
