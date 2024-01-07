import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import 'package:teacher/no_need/page_check_list.dart';
// import 'package:teacher/page_Home.dart';
// import 'package:teacher/page_check_list.dart';
import 'package:teacher/widgets/side_menu.dart';
// import 'package:teacher/subject.dart';
import 'package:teacher/models/edit_settings.dart';
import 'package:teacher/widgets/belongings_data.dart';
import 'package:teacher/models/timetables.dart';
import 'package:teacher/widgets/timetables_data.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

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
    return Scaffold(
        body: Row(children: [
      const SizedBox(
        width: 300, // サイドメニューの幅
        child: SideMenu(),
      ),
      SizedBox(
        width: 500,
        child: pages[pageId],
      ),
    ]));
  }
}

//以下でサイドメニューのWidgetを作成
//仮で画面キャプチャーした画像を表示
class StudentEdit extends StatelessWidget {
  const StudentEdit({super.key});

  @override
  Widget build(BuildContext context) {
    // return Image.asset('images/studentEdit.png');
    return FutureBuilder<List<dynamic>>(
        future: getStudentsApiData(),
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
            debugPrint('#89 data; $data');
            return SizedBox(
              // height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                      columns: const [
                        DataColumn(label: Text("出席番号")),
                        DataColumn(label: Text("名前"))
                      ],
                      rows: List<DataRow>.generate(20, (i) {
                        final studentId = data![i]["id"];
                        final studentName = data[i]["student_name"];

                        return DataRow(cells: [
                          DataCell(Text("$studentId")),
                          DataCell(Text(studentName)),
                        ]);
                      })),
                  DataTable(
                      columns: const [
                        DataColumn(label: Text("出席番号")),
                        DataColumn(label: Text("名前"))
                      ],
                      rows: List<DataRow>.generate(15, (i) {
                        final studentId = data![i + 20]["id"];
                        final studentName = data[i + 20]["student_name"];

                        return DataRow(cells: [
                          DataCell(Text("$studentId")),
                          DataCell(Text(studentName)),
                        ]);
                      })),
                ],
              ),
            );
          }
        });
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

          return Column(children: [
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(80),
                2: FixedColumnWidth(80),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(80),
                5: FixedColumnWidth(80),
              },
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment:
                  TableCellVerticalAlignment.middle, //各セルの上下方向の文字位置変更

              children: [
                TableRow(
                  children: List.generate(6, (index) {
                    if (index == 0) {
                      return const Center(
                        child: SizedBox(
                            height: 80, child: Center(child: Text('時間割表'))),
                      );
                    } else {
                      final day = data!.timetableList[index - 1].day;
                      return Center(child: Text(day));
                    }
                  }),
                ),
                for (int i = 0; i < 5; i++)
                  TableRow(
                    children: List.generate(6, (index) {
                      if (index == 0) {
                        return Center(
                          child: SizedBox(
                              height: 80,
                              child: Center(
                                child: Text('${i + 1}'),
                              )),
                        );
                      } else if (data!
                              .timetableList[index - 1].subjects.length <
                          5) {
                        return const Center(child: Text('🦆'));
                      } else {
                        final subjectName = data
                            .timetableList[index - 1].subjects[i].subject_name;
                        return Center(child: Text(subjectName));
                      }
                    }),
                  ),
              ],
            ),
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
    return FutureBuilder<List<dynamic>>(
        future: getBelongingsApiData3(),
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
            debugPrint('#239;$data');

            return SizedBox(
              child: Row(children: [
                DataTable(
                    dataRowMaxHeight: 80,
                    columns: const [
                      DataColumn(label: Text('科目')),
                      DataColumn(label: Text('持ち物')),
                    ],
                    rows: List<DataRow>.generate(data!.length, (i) {
                      return DataRow(cells: [
                        DataCell(Text(data[i]['subject_name'].toString())),
                        DataCell(Column(
                          children: List.generate(
                            data[i]['belongings'].length,
                            (j) => Text(data[i]['belongings'][j].toString()),
                          ),
                        ))
                      ]);
                    })),
              ]),
            );
            //   ],
            // );
          }
        });
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
