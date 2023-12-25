import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:teacher/page_Home.dart';
// import 'package:teacher/page_check_list.dart';
import 'package:teacher/side_menu.dart';
// import 'package:teacher/subject.dart';
import 'package:teacher/edit_settings.dart';

// class PageSettings extends StatelessWidget {
class PageSettings extends ConsumerWidget {
  const PageSettings({super.key});

  @override
  // Widget build(BuildContext context) {

  Widget build(BuildContext context, WidgetRef ref) {
    //サイドメニューのリストの表示画面設定

    final pages = [
      const StudentEdit(),
      const TimetableEdit(),
      const BelongingsEdit(),
      const ItemsEdit(),
      const EventEdit()
    ];

    final pageId = ref.watch(editScreenNotifierProvider);
    // debugPrint("check id : $pageId");
    return Scaffold(
        body: Row(children: [
      const SizedBox(
        width: 300, // サイドメニューの幅
        child: SideMenu(),
      ),
      Center(
          child: SizedBox(
        width: 300,
        child: pages[pageId],
      ))
    ]));
    // ]
    // )
    // );
  }
}

//以下でサイドメニューのWidgetを作成
//仮で画面キャプチャーした画像を表示
class StudentEdit extends StatelessWidget {
  const StudentEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/studentEdit.png');
  }
}

class TimetableEdit extends StatelessWidget {
  const TimetableEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/timetableEdit.png');
  }
}

class BelongingsEdit extends StatelessWidget {
  const BelongingsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/belongingsEdit.png');
  }
}

class ItemsEdit extends StatelessWidget {
  const ItemsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/itemsEdit.png');
  }
}

class EventEdit extends StatelessWidget {
  const EventEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/eventEdit.png');
  }
}
