import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:teacher/main_screen.dart';
import 'dart:collection';
// import 'package:teacher/page_check_list.dart';
import "package:intl/intl.dart";
import 'package:teacher/models/belongings.dart';
import 'package:teacher/widgets/belongings_data.dart';
import "package:teacher/models/index.dart";
import "package:teacher/models/date.dart";
import "package:http/http.dart" as http;
import "dart:convert";

Future<List<Map<String, dynamic>>> getStudents() async {
  final url = Uri.https("motta-9dbb2df4f6d7.herokuapp.com",
      "/api/v1/teacher/home/history", {"date": "2023-12-21"});

  try {
    final res = await http.get(url);
    final data = await json.decode(res.body);
    debugPrint("うまくいってます！");

    final List<Map<String, dynamic>> studentNames =
        List<Map<String, dynamic>>.from(
            data["studentsHistory"].map((student) => student));
    debugPrint(studentNames.toString());

    return studentNames;
  } catch (error) {
    debugPrint("エラーです！");
    throw Future.error("エラーが発生しました: $error");
  }
}

class PageHome extends ConsumerWidget {
  PageHome({super.key});

  final Map<DateTime, List> _eventsList = {
    DateTime.now().subtract(const Duration(days: 3)): ['Test A', 'Test B', 'c'],
    DateTime.now(): ['Test C', 'Test D', 'Test E', 'Test F'],
  };
  late final DateTime _focused = DateTime.now();
  late final DateTime _selected = _focused;

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
    )..addAll(_eventsList);

    List getEvent(DateTime day) {
      return events[day] ?? [];
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2022, 4, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              eventLoader: getEvent, //追記
              selectedDayPredicate: (day) {
                return isSameDay(_selected, day);
              },
              onDaySelected: (selected, focused) async {
                // if (!isSameDay(_selected, selected)) {
                final f = DateFormat('yyyy-MM-dd');
                final selectedDate = f.format(selected);
                debugPrint('selected:$selectedDate');
                final DayBelongings data =
                    await getBelongingsApiData(date: selectedDate);
                debugPrint("data: $data");
                ref
                    .read(dateNotifierProvider.notifier)
                    .updateState("$selected");
                ref
                    .read(dayBelongingsNotifierProvider.notifier)
                    .updateState(data);
                ref.read(indexNotifierProvider.notifier).updateState(1);
              },
              focusedDay: _focused,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // データがまだ取得されていない場合の表示
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // エラーが発生した場合の表示
                  return Text('エラー: ${snapshot.error}');
                } else {
                  // データを表示
                  final List<Map<String, dynamic>> data = snapshot.data!;
                  return Wrap(
                    children: data
                            .map((el) => Container(
                                  margin: const EdgeInsets.all(8.0),
                                  height: 70,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      // color: Colors.grey,
                                      color: el["checkedInventory"]
                                          ? Colors.green
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topCenter,
                                        child: Icon(Icons.person,
                                            size: 24, color: Colors.white),
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child:
                                            Text(el["student_name"].toString()),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList() ??
                        [],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
