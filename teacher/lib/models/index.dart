import "package:riverpod_annotation/riverpod_annotation.dart";
part 'index.g.dart';

@riverpod
class IndexNotifier extends _$IndexNotifier {
  @override
  int build() {
    return 2;
  }

  void updateState(newState) {
    state = newState;
  }
}
