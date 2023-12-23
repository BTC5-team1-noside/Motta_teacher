// import 'dart:ffi';

// import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:teacher/page_Home.dart';
// import 'package:teacher/page_check_list.dart';
// import 'package:teacher/page_setting.dart';
part 'edit_settings.g.dart';

// final pages = [const PageHome(), const PageCheckList(), const PageSettings()];
// final pageId = [0, 1, 2];

@riverpod
class EditScreenNotifier extends _$EditScreenNotifier {
  @override
  // Widget build() {
  int build() {
    return 0;
  }

  void updateScreen(int id) {
    state = id;
  }
}
