import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'edit_settings.g.dart';

@riverpod
class EditScreenNotifier extends _$EditScreenNotifier {
  @override
  int build() {
    return 0;
  }

  void updateScreen(int id) {
    state = id;
  }
}
