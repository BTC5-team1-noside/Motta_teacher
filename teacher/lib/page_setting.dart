import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/page_Home.dart';
import 'package:teacher/page_check_list.dart';
import 'package:teacher/side_menu.dart';
import 'package:teacher/subject.dart';
import 'package:teacher/edit_settings.dart';

// class PageSettings extends StatelessWidget {
class PageSettings extends ConsumerWidget {
  const PageSettings({super.key});

  @override
  // Widget build(BuildContext context) {

  Widget build(BuildContext context, WidgetRef ref) {
    final pages = [const PageHome(), const PageCheckList()];
    final pageId = ref.watch(editScreenNotifierProvider);
    debugPrint("check id : $pageId");
    return Scaffold(
        body: Row(children: [
      const SizedBox(
        width: 300, // サイドメニューの幅
        child: SideMenu(),
      ),
      Center(
          child: SizedBox(
              width: 300, child: pages[pageId]) //Text('これが表示されたか？$pageId')

          // switch (subject) {
          // Subject.japanese => "国語",
          // Subject.math => "sansu",
          // Subject.science => 'rika',
          // Subject.society => 'syaki',
          // Subject.english => 'eigo',
          // },
          // "SAMPLE TEXT",
          // style: const TextStyle(color: Colors.black, fontSize: 25),

          )
    ]));
  }
}
