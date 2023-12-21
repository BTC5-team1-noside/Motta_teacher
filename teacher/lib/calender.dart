import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<DateTime, List> _eventsList = {};

  DateTime _focused = DateTime.now();
  DateTime? _selected;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();

    _selected = _focused;
    _eventsList = {
      DateTime.now().subtract(const Duration(days: 2)): ['Test A', 'Test B'],
      DateTime.now(): ['Test C', 'Test D', 'Test E', 'Test F'],
    };
  }

  @override
  Widget build(BuildContext context) {
    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEvent(DateTime day) {
      return events[day] ?? [];
    }

    // 進むボタンを押したとき
    push(BuildContext context) {
      context.go('/a');
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
        onDaySelected: (selected, focused) {
          if (!isSameDay(_selected, selected)) {
            debugPrint('here');
            push(context);
            setState(() {
              _selected = selected;
              _focused = focused;
            });
          }
        },
        focusedDay: _focused,
      ),
      //--追記--------------------------------------------------------------
      ListView(
        shrinkWrap: true,
        children: getEvent(_selected!)
            .map((event) => ListTile(
                  title: Text(event.toString()),
                ))
            .toList(),
      )
      //--------------------------------------------------------------------
    ]));
  }
}
