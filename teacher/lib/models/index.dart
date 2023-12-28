import "package:riverpod_annotation/riverpod_annotation.dart";
part 'index.g.dart';

@riverpod
class IndexNotifier extends _$IndexNotifier {
  @override
  int build() {
    return 0;
  }

  void updateState(newState) {
    state = newState;
  }
}
