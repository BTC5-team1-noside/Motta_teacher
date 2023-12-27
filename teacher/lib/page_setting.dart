import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/belongings.dart';
import 'package:teacher/page_check_list.dart';
// import 'package:teacher/page_Home.dart';
// import 'package:teacher/page_check_list.dart';
import 'package:teacher/side_menu.dart';
// import 'package:teacher/subject.dart';
import 'package:teacher/edit_settings.dart';
import 'package:teacher/belongings_data.dart';
import 'package:teacher/timetables.dart';
import 'package:teacher/timetables_data.dart';

// class PageSettings extends StatelessWidget {
class PageSettings extends ConsumerWidget {
  const PageSettings({super.key});

  @override
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
    final Future<DayBelongings> data = getBelongingsApiData();
    debugPrint("取得したデータは$data");
    return Image.asset('images/studentEdit.png');
  }
}

class TimetableEdit extends StatelessWidget {
  const TimetableEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Timetables>(
      future: getTimetablesApiData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データがまだ取得されていない場合の処理
          return const CircularProgressIndicator(); // 例: ローディングインジケータを表示
        } else if (snapshot.hasError) {
          // エラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          final data = snapshot.data;
          // debugPrint('取得したデータは!! $data');
          // ここで取得したデータを使ってウィジェットを構築する

          List<Widget> cols = [];
          for (int i = 0; i < data!.timetableList.length; i++) {
            List<Widget> rows = [];
            for (int j = 0; j < data.timetableList[i].subjects.length; j++) {
              final row = Row(
                children: [
                  // Text(data!.timetableList[i].day),
                  Text(data.timetableList[i].subjects[j].subject_name),
                  // Text(data.timetableList[i].subjects[j].subject_name)
                ],
              );
              rows.add(row);
            }
            final col = Column(
              children: [
                Text(data.timetableList[i].day),
                // 他のデータやウィジェットの構築もここに追加できます
                Column(children: rows),
              ],
            );
            cols.add(col);
          }

          return Column(children: [
            Image.asset('images/timetableEdit.png'),
            // Text(data!.timetableList[0].day),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cols,
            )
          ]);
        }
      },
    );
  }

  // Widget build(BuildContext context) {
  //   return Image.asset('images/timetableEdit.png');
  // }
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
