import "package:riverpod_annotation/riverpod_annotation.dart";
part 'date.g.dart';

@riverpod
class DateNotifier extends _$DateNotifier {
  @override
  String build() {
    return "2023-12-25";
  }

  void updateState(newState) {
    state = newState;
  }
}
