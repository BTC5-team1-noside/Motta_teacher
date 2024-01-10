// import 'dart:html';
// import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:teacher/main_screen.dart';
import 'dart:collection';
// import 'package:teacher/page_check_list.dart';
// import "package:intl/intl.dart";
import 'package:teacher/models/belongings.dart';
import 'package:teacher/widgets/belongings_data.dart';
import "package:teacher/models/index.dart";
import "package:teacher/models/date.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> getStudents(DateTime? selectedDate) async {
  final formatDate = DateFormat("yyyy-MM-dd");
  DateTime currentDate = selectedDate ?? DateTime.now();
  final formattedDate = formatDate.format(currentDate);
  final url = Uri.https("motta-9dbb2df4f6d7.herokuapp.com",
      "/api/v1/teacher/home/history", {"date": formattedDate});

  try {
    final res = await http.get(url);
    final data = await json.decode(res.body);
    debugPrint("うまくいってます！");

    final List<Map<String, dynamic>> studentNames =
        List<Map<String, dynamic>>.from(
            data["studentsHistory"].map((student) => student));
    // debugPrint(studentNames.toString());

    return studentNames;
  } catch (error) {
    debugPrint("エラーです！");
    throw Future.error("エラーが発生しました: $error");
  }
}

Future<List<String>> getStudentsHistoryDate(DateTime? selectedDate) async {
  final formatDate = DateFormat("yyyy-MM-dd");
  DateTime currentDate = selectedDate ?? DateTime.now();
  final formattedDate = formatDate.format(currentDate);
  final url = Uri.https("motta-9dbb2df4f6d7.herokuapp.com",
      "/api/v1/teacher/home/history", {"date": formattedDate});

  // データが既にキャッシュされているか確認
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getStringList('studentsHistoryDate_$formattedDate');
  if (cachedData != null) {
    debugPrint("キャッシュデータを使用します！");
    return cachedData;
  }

  try {
    final res = await http.get(url);
    final data = await json.decode(res.body);
    debugPrint("うまくいってます！");

    final List<String> studentsHistoryDate =
        List<String>.from(data["timeTablesHistoryDates"].map((date) => date));

    // データをキャッシュに保存
    prefs.setStringList(
        'studentsHistoryDate_$formattedDate', studentsHistoryDate);

    return studentsHistoryDate;
  } catch (error) {
    debugPrint("エラーです！");
    throw Future.error("エラーが発生しました: $error");
  }
}

class PageHome extends ConsumerWidget {
  PageHome({super.key});

  late DateTime _focused = DateTime.now();
  DateTime? _selected; // DateTime?型を使用

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(indexNotifierProvider);
    ref.watch(dateNotifierProvider);
    ref.watch(dayBelongingsNotifierProvider);

    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    List getEvent(DateTime day) {
      return events[day] ?? [];
    }

    late Future<List<String>> historyDatesFuture;
    historyDatesFuture =
        getStudentsHistoryDate(_selected != null ? _selected! : DateTime.now());

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 450,
              // color: const Color.fromARGB(255, 236, 236, 236),
              margin: const EdgeInsets.only(top: 0),
              // color: Colors.amber,
              child: TableCalendar(
                firstDay: DateTime.utc(2022, 4, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                eventLoader: getEvent,
                selectedDayPredicate: (day) {
                  // print(isSameDay(_selected, day));
                  return isSameDay(_selected, day);
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  weekendStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  dowTextFormatter: (date, locale) {
                    switch (date.weekday) {
                      case 1:
                        return "月";
                      case 2:
                        return "火";
                      case 3:
                        return "水";
                      case 4:
                        return "木";
                      case 5:
                        return "金";
                      case 6:
                        return "土";
                      case 7:
                        return "日";
                      default:
                        return "";
                    }
                  },
                ),
                rowHeight: 55,
                daysOfWeekHeight: 40,
                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  titleTextFormatter: (date, locale) {
                    return DateFormat("yyyy年 MM月 dd日 (E)", "ja_JP")
                        .format(date);
                  },
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    final formattedDate = DateFormat('yyyy-MM-dd').format(day);

                    // ここで選択された日付と同じ月であるかどうかを確認
                    debugPrint("$day.month");

                    return FutureBuilder<List<String>>(
                      future: historyDatesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('エラー: ${snapshot.error}');
                        } else {
                          final List<String> data = snapshot.data!;
                          final hasIcon = data.contains(formattedDate);

                          // 同じ月である場合のみアイコンを表示
                          return hasIcon
                              ? Positioned(
                                  bottom: 7,
                                  child: Container(
                                    margin: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }
                      },
                    );
                  },
                  selectedBuilder: (context, date, events) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.blue, // 選択中の日付の背景色を指定
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white, // 選択中の日付の文字色を指定
                        ),
                      ),
                    );
                  },
                  defaultBuilder: (context, date, events) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (context, date, events) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 243, 128, 21), // 選択中の日付の背景色を指定
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white, // 選択中の日付の文字色を指定
                        ),
                      ),
                    );
                  },
                ),
                onDaySelected: (selected, focused) async {
                  final formatDate = DateFormat('yyyy-MM-dd');
                  final selectedDate = formatDate.format(selected);
                  // debugPrint('selected:$selectedDate');
                  _selected = selected;
                  _focused = focused;

                  ref
                      .read(dateNotifierProvider.notifier)
                      .updateState("$selected");
                  final DayBelongings data =
                      await getBelongingsApiData(date: selectedDate);
                  ref
                      .read(dayBelongingsNotifierProvider.notifier)
                      .updateState(data);
                },
                focusedDay: _focused,
                onPageChanged: (focusedDay) {
                  debugPrint("月変えた？");
                  // final formattedDate =
                  //     DateFormat('yyyy-MM-dd').format(focusedDay);
                  // print("Displayed month: $formattedDate");
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.all(10),
              width: 300,
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // ボタンが押されたときの色
                        return Colors.blue;
                      }
                      // ボタンが通常の状態の色
                      return const Color.fromARGB(255, 4, 45, 207);
                    },
                  ),
                ),
                onPressed: () async {
                  // print("持ち物登録ボタンが押された");
                  // print(_selected)
                  final DayBelongings data = await getBelongingsApiData(
                    date: _selected != null
                        ? DateFormat('yyyy-MM-dd').format(_selected!)
                        : DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  );
                  debugPrint("data: $data");
                  ref
                      .read(dateNotifierProvider.notifier)
                      .updateState("$_selected");

                  ref
                      .read(dayBelongingsNotifierProvider.notifier)
                      .updateState(data);
                  ref.read(indexNotifierProvider.notifier).updateState(1);
                },
                child: const Text(
                  "持ち物登録を行う",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 460,
                  width: double.infinity,
                  // color: Colors.green.shade900,
                  padding: const EdgeInsets.all(45),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/monitor.png"),
                        fit: BoxFit.contain),
                  ),

                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _selected != null
                        ? getStudents(_selected!)
                        : getStudents(DateTime.now()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('エラー: ${snapshot.error}');
                      } else if (snapshot.data == null) {
                        return const Text('データがありません');
                      } else {
                        final List<Map<String, dynamic>> data = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 10,
                                  childAspectRatio: 1.0,
                                  mainAxisSpacing: 3.0,
                                  crossAxisSpacing: 3.0),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final el = data[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: el["checkedInventory"]
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: el["checkedInventory"]
                                    ? [
                                        const Icon(
                                          Icons.face_retouching_natural,
                                          size: 27,
                                          color:
                                              Color.fromARGB(255, 74, 255, 3),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 60,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade500
                                                .withOpacity(0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Text(
                                            el["student_name"].toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ]
                                    : [
                                        const Icon(
                                          Icons.face,
                                          size: 27,
                                          color: Color.fromARGB(
                                              255, 250, 250, 250),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 60,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade500
                                                .withOpacity(0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Text(
                                            el["student_name"].toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
