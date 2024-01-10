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
      SizedBox(
        width: 220, // サイドメニューの幅
        child: SideMenu(),
      ),
      SizedBox(
        width: 600,
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
                    }),
                    // decoration: const BoxDecoration(color: Colors.amber),
                  ),
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

          return Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 60,
                child: Text(
                  '時間割 編集',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 77, 77, 77)),
                ),
              ),
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(70),
                  1: FixedColumnWidth(95),
                  2: FixedColumnWidth(95),
                  3: FixedColumnWidth(95),
                  4: FixedColumnWidth(95),
                  5: FixedColumnWidth(95),
                },
                border: TableBorder.all(
                  color: const Color.fromARGB(255, 122, 122, 122),
                  style: BorderStyle.solid,
                  width: 0.5,
                ),
                defaultVerticalAlignment:
                    TableCellVerticalAlignment.middle, //各セルの上下方向の文字位置変更

                children: [
                  TableRow(
                    children: List.generate(6, (index) {
                      if (index == 0) {
                        return Center(
                          child: Container(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            height: 50,
                            child: const Center(child: Text('時間割表')),
                          ),
                        );
                      } else {
                        final day = data!.timetableList[index - 1].day;
                        return Center(
                            child: Text(
                          day,
                          style: const TextStyle(fontSize: 22),
                        ));
                      }
                    }),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 216, 216, 216),
                    ),
                  ),
                  for (int i = 0; i < 5; i++)
                    TableRow(
                      children: List.generate(6, (index) {
                        if (index == 0) {
                          return Center(
                            child: SizedBox(
                                height: 80,
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                )),
                          );
                        } else if (data!
                                .timetableList[index - 1].subjects.length <
                            5) {
                          return const Center(child: Text('🦆'));
                        } else {
                          final subjectName = data.timetableList[index - 1]
                              .subjects[i].subject_name;
                          return Center(child: Text(subjectName));
                        }
                      }),
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                ],
              ),
            ]),
          );
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

  // const BelongingsEdit({Key? key}) : super(key: key);

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

            return Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                    child: Text(
                      '科目別 持ち物編集',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 77, 77, 77)),
                    ),
                  ),
                  SizedBox(
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(150), // 列の幅を設定する場合
                        1: FixedColumnWidth(400),
                      },
                      border: TableBorder.all(
                        color: const Color.fromARGB(255, 122, 122, 122),
                        style: BorderStyle.solid,
                        width: 0.5,
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 216, 216, 216)),
                          children: [
                            Center(
                              child: SizedBox(
                                height: 50, // 高さを設定
                                child: Center(
                                  child: Text(
                                    '科目',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 50, // 高さを設定
                                child: Center(
                                  child: Text(
                                    '持ち物',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < data!.length; i++)
                          TableRow(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: Text(
                                        data[i]['subject_name'].toString(),
                                        // textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Column(
                                    children: List.generate(
                                      data[i]['belongings'].length,
                                      (j) => Text(
                                        data[i]['belongings'][j].toString(),
                                        // textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              decoration:
                                  const BoxDecoration(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
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
    return FutureBuilder<List<dynamic>>(
        future: getItemsApiData(),
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

            return
                // Column(
                //   children: [
                // Image.asset('images/itemsEdit.png'),
                // Text(data![0]['id'].toString()),
                DataTable(
                    columns: const [
                  DataColumn(label: Text('id')),
                  DataColumn(label: Text('アイテム')),
                ],
                    rows: List<DataRow>.generate(data!.length, (i) {
                      return DataRow(cells: [
                        DataCell(Text(data[i]['id'].toString())),
                        DataCell(Column(
                          children: List.generate(
                            data[i]['item_name'].length,
                            (j) => Text(data[i]['item_name'][j].toString()),
                          ),
                        ))
                      ]);
                    }));
            //   ],
            // );
          }
        });
  }
}

class EventEdit extends StatelessWidget {
  const EventEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getEventsApiData(),
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
            return
                // Column(
                //   children: [
                // Image.asset('images/eventEdit.png'),
                // Text('${data![0]['event_name']}'),
                SizedBox(
              child: Row(children: [
                DataTable(
                    dataRowMaxHeight: 180,
                    columns: const [
                      DataColumn(label: Text('日付')),
                      DataColumn(label: Text('イベント名')),
                      DataColumn(label: Text('持ち物')),
                    ],
                    rows: List<DataRow>.generate(data!.length, (i) {
                      return DataRow(cells: [
                        DataCell(Text(data[i]['date'].toString())),
                        DataCell(Text(data[i]['event_name'].toString())),
                        DataCell(Column(
                          children: List.generate(
                            data[i]['itemNames'].length,
                            (j) => Text(data[i]['itemNames'][j].toString()),
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
