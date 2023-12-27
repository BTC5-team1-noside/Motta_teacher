import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:teacher/main_screen.dart';
import 'dart:collection';
// import 'package:teacher/page_check_list.dart';
import "package:intl/intl.dart";
import 'package:teacher/belongings.dart';
import 'package:teacher/belongings_data.dart';
import "package:teacher/models/index.dart";
import "package:teacher/models/date.dart";

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key});

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
        body: Column(children: [
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
          ref.read(dateNotifierProvider.notifier).updateState("$selected");
          ref.read(dayBelongingsNotifierProvider.notifier).updateState(data);
          ref.read(indexNotifierProvider.notifier).updateState(1);
          // setState(() {
          //   _selected = selected;
          //   _focused = focused;
          // });
          // }
        },
        focusedDay: _focused,
      ),
      // ListView(
      //   shrinkWrap: true,
      //   children: getEvent(_selected!)
      //       .map((event) => ListTile(
      //             title: Text(event.toString()),
      //           ))
      //       .toList(),
      // )
    ]));
  }
}
