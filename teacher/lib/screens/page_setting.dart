import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:teacher/models/belongings.dart';
// import 'package:teacher/no_need/page_check_list.dart';
// import 'package:teacher/page_Home.dart';
// import 'package:teacher/page_check_list.dart';
import 'package:teacher/widgets/side_menu.dart';
// import 'package:teacher/subject.dart';
import 'package:teacher/models/edit_settings.dart';
// import 'package:teacher/widgets/belongings_data.dart';
import 'package:teacher/models/timetables.dart';
import 'package:teacher/widgets/timetables_data.dart';
// import "package:http/http.dart" as http;
// import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return FutureBuilder<List<dynamic>>(
      future: getStudentsApiData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データがまだ取得されていない場合の処理
          return const SpinKitFadingCircle(
            color: Colors.grey,
            size: 100.0,
          );
        } else if (snapshot.hasError) {
          // エラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          final data = snapshot.data;
          debugPrint('#89 data; $data');
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                      child: Text(
                        '生徒編集',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 96, 96, 96)),
                      ),
                    ),
                    Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(200),
                        1: FixedColumnWidth(350),
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
                                      '出席番号',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  height: 50, // 高さを設定
                                  child: Center(
                                    child: Text(
                                      '名前',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        for (var i = 0; i < data!.length; i++)
                          TableRow(
                            children: List.generate(2, (index) {
                              if (index == 0) {
                                return Center(
                                  child: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text("${i + 1}"),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(data[i]["student_name"]),
                                    ),
                                  ),
                                );
                              }
                            }),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          )
                      ],
                    )
                  ]),
            ),
          );
        }
      },
    );
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
          return const SpinKitFadingCircle(
            color: Colors.grey,
            size: 100.0,
          );
        } else if (snapshot.hasError) {
          // エラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          final data = snapshot.data;

          return Container(
            margin: const EdgeInsets.only(left: 30, top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 60,
                child: Text(
                  '時間割 編集',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 96, 96, 96)),
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
                          style: const TextStyle(fontSize: 16),
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
            return const SpinKitFadingCircle(
              color: Colors.grey,
              size: 100.0,
            );
          } else if (snapshot.hasError) {
            // エラーが発生した場合の処理
            return Text('Error: ${snapshot.error}');
          } else {
            // データが正常に取得された場合の処理
            final data = snapshot.data;
            debugPrint('#239;$data');

            return Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                    child: Text(
                      '科目別 持ち物編集',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 96, 96, 96)),
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
                                    style: TextStyle(fontSize: 16),
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
                                    style: TextStyle(fontSize: 16),
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
          }
        });
  }
}

class ItemsEdit extends StatelessWidget {
  const ItemsEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getItemsApiData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データがまだ取得されていない場合の処理
          return const SpinKitFadingCircle(
            color: Colors.grey,
            size: 100.0,
          );
        } else if (snapshot.hasError) {
          // エラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          final data = snapshot.data;
          debugPrint('#239;$data');

          return Container(
            margin: const EdgeInsets.only(left: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                  child: Text(
                    "日常品 編集",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 96, 96, 96)),
                  ),
                ),
                SizedBox(
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(80),
                      1: FixedColumnWidth(310),
                      2: FixedColumnWidth(150),
                    },
                    border: TableBorder.all(
                      color: const Color.fromARGB(255, 122, 122, 122),
                      style: BorderStyle.solid,
                      width: 0.5,
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                                  'No',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 50, // 高さを設定
                              child: Center(
                                child: Text(
                                  '持ち物の名前',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 50, // 高さを設定
                              child: Center(
                                child: Text(
                                  '頻度',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < 4; i++)
                        TableRow(
                          children: List.generate(
                            3,
                            (index) {
                              if (index == 0) {
                                return Center(
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text("${i + 1}"),
                                    ),
                                  ),
                                );
                              } else if (index == 1) {
                                return Center(
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(data![i]["item_name"]),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(data![i]["day"]),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          decoration: const BoxDecoration(color: Colors.white),
                        )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
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
          return const SpinKitFadingCircle(
            color: Colors.grey,
            size: 100.0,
          );
        } else if (snapshot.hasError) {
          // エラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          final data = snapshot.data;
          debugPrint('#239;$data');

          return Container(
            margin: const EdgeInsets.only(left: 30, top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 60,
                child: Text(
                  'イベント登録',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 96, 96, 96)),
                ),
              ),
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(70),
                  1: FixedColumnWidth(170),
                  2: FixedColumnWidth(150),
                  3: FixedColumnWidth(150),
                },
                border: TableBorder.all(
                  color: const Color.fromARGB(255, 122, 122, 122),
                  style: BorderStyle.solid,
                  width: 0.5,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                              'No',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 50, // 高さを設定
                          child: Center(
                            child: Text(
                              'イベント名',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 50, // 高さを設定
                          child: Center(
                            child: Text(
                              '持ち物の名前',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 50, // 高さを設定
                          child: Center(
                            child: Text(
                              '登録日',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < data!.length; i++)
                    TableRow(
                      children: List.generate(
                        4,
                        (index) {
                          if (index == 0) {
                            return Center(
                              child: SizedBox(
                                height: 170,
                                child: Center(
                                  child: Text("${i + 1}"),
                                ),
                              ),
                            );
                          } else if (index == 1) {
                            return Center(
                              child: SizedBox(
                                height: 170,
                                child: Center(
                                  child: Text(data[i]["event_name"]),
                                ),
                              ),
                            );
                          } else if (index == 2) {
                            return Center(
                              child: SizedBox(
                                height: 170,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        data[i]["itemNames"].length,
                                        (index) =>
                                            Text(data[i]["itemNames"][index]),
                                      )),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: SizedBox(
                                height: 170,
                                child: Center(
                                  child: Text(data[i]["date"]),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      decoration: const BoxDecoration(color: Colors.white),
                    )
                ],
              ),
            ]),
          );
        }
      },
    );
  }
}
