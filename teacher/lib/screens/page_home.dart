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
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  // late DateTime _selected = DateTime(2024, 1, 22); // DateTime?型を使用

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
    historyDatesFuture = getStudentsHistoryDate(_selected ?? DateTime.now());

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              // height: 450,
              // color: const Color.fromARGB(255, 239, 248, 249),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 116, 116, 116),
                  ),
                  weekendStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
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
                rowHeight: 65,
                daysOfWeekHeight: 40,
                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 64, 64, 64),
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
                    // debugPrint("$day.month");

                    return FutureBuilder<List<String>>(
                      future: historyDatesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 30.0,
                          );
                        } else if (snapshot.hasError) {
                          return Text('エラー: ${snapshot.error}');
                        } else {
                          final List<String> data = snapshot.data!;
                          final hasIcon = data.contains(formattedDate);

                          // 同じ月である場合のみアイコンを表示
                          return hasIcon
                              ? Positioned(
                                  bottom: 15,
                                  child: Container(
                                    margin: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 30,
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
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 1),
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    );
                  },
                  defaultBuilder: (context, date, events) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 1),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: date.weekday == 6 || date.weekday == 7
                                ? Colors.red
                                : const Color.fromARGB(255, 116, 116, 116),
                          ),
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (context, date, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(85, 255, 255, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 1),
                        child: Text(
                          '${date.day}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 211, 208, 208),
                          ),
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 128, 21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 1),
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 70,
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () async {
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 上下の中央揃え
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.fact_check,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "持ち物登録する",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                    child: Text(
                      "生徒の持ち物確認の実施履歴",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 96, 96, 96)),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 205, 205, 205),
                    thickness: 1.0,
                  ),
                  Container(
                    height: 340,
                    width: 800,
                    // color: Colors.amber,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _selected != null
                          ? getStudents(_selected)
                          : getStudents(DateTime.now()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 100.0,
                          );
                        } else if (snapshot.hasError) {
                          return Text('エラー: ${snapshot.error}');
                        } else if (snapshot.data == null) {
                          return const Text('データがありません');
                        } else {
                          final List<Map<String, dynamic>> data =
                              snapshot.data!;
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7,
                                    childAspectRatio: 1.7,
                                    mainAxisSpacing: 3.0,
                                    crossAxisSpacing: 3.0),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final el = data[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: el["checkedInventory"]
                                      ? Colors.green.withOpacity(0.9)
                                      : Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: el["checkedInventory"]
                                      ? [
                                          const Icon(
                                              Icons.face_retouching_natural,
                                              size: 27,
                                              color:
                                                  // Color.fromARGB(255, 74, 255, 3),
                                                  Colors.white),
                                          const SizedBox(height: 4),
                                          Container(
                                            width: 60,
                                            // padding: const EdgeInsets.all(2),
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
                                            // width: 70,
                                            // padding: const EdgeInsets.all(2),
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
                                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}
