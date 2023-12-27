import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import 'package:teacher/models/subject.dart';
import 'package:teacher/models/subject_2.dart';
import 'package:teacher/widgets/belongings_data.dart';
import 'package:intl/intl.dart';
import "package:teacher/models/date.dart";
import "package:teacher/widgets/belongings.dart";
import 'package:teacher/widgets/subject_dropdown.dart';

class PageCheckListGon extends ConsumerWidget {
  const PageCheckListGon({super.key});

  List<Widget> generateTimeTable(DayBelongings pathData) {
    List<Widget> rows = [];
    for (int i = 0; i < pathData.subjects.length; i++) {
      final row = Row(
        children: [
          Text(
            "${i + 1}時間目: ",
            style: const TextStyle(color: Colors.black, fontSize: 32),
          ),
          Text(
            pathData.subjects[i].subject_name,
            style: const TextStyle(color: Colors.black, fontSize: 32),
          )
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dt = ref.watch(dateNotifierProvider);
    final DayBelongings dayData = ref.watch(dayBelongingsNotifierProvider);
    final timetable = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: generateTimeTable(dayData).toList());
    final belongings = Belongings(pathData: dayData);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  debugPrint('日にちを減らす');
                  debugPrint(dayData.selectedDate);
                  final timeF = DateTime.parse(dayData.selectedDate)
                      .add(const Duration(days: -1));
                  final f = DateFormat('yyyy-MM-dd');
                  final beforeDay = f.format(timeF);
                  debugPrint(beforeDay);
                  ref
                      .read(dateNotifierProvider.notifier)
                      .updateState(beforeDay);
                  final DayBelongings data =
                      await getBelongingsApiData(date: beforeDay);
                  ref
                      .read(dayBelongingsNotifierProvider.notifier)
                      .updateState(data);
                  // final timeB = DateTime.parse(data.selectedDate);
                  // const durC = Duration(days: -1);
                  // final timeD = timeB.add(durC);
                },
                child: const Text('<')),
            const SizedBox(
              width: 50,
            ),
            Text(dayData.selectedDate,
                style: const TextStyle(color: Colors.black, fontSize: 32)),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  debugPrint('日にちを増やす');
                  final timeF = DateTime.parse(dayData.selectedDate)
                      .add(const Duration(days: 1));
                  final f = DateFormat('yyyy-MM-dd');
                  final afterDay = f.format(timeF);
                  ref.read(dateNotifierProvider.notifier).updateState(afterDay);
                  final DayBelongings data =
                      await getBelongingsApiData(date: afterDay);
                  ref
                      .read(dayBelongingsNotifierProvider.notifier)
                      .updateState(data);
                },
                child: const Text('>')),
          ],
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            timetable,
            belongings,
          ],
        ),
        const Text('ここに追加アイテムの記入欄を表示させたい'),
        ElevatedButton(
          onPressed: () {
            debugPrint('ここにPOSTメソッドでバックエンドへデータを送付');
          },
          child: const Text('登録'),
        ),
        const SizedBox(width: 200, child: SubjectDropdown()),
      ],
    );
  }
}
