import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject.g.dart';

enum Subject {
  japanese,
  math,
  science,
  society,
  english,
}

@riverpod
class SubjectNotifier extends _$SubjectNotifier {
  @override
  Subject build() {
    return Subject.japanese;
  }

  void updateSubject(Subject subject) {
    state = subject;
  }
}
