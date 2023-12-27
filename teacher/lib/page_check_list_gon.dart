import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/belongings.dart';
import 'package:teacher/subject.dart';
import 'package:teacher/subject_2.dart';
import 'package:teacher/belongings_data.dart';
import 'package:intl/intl.dart';
import "package:teacher/models/date.dart";

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
    final timetable = Column(children: generateTimeTable(dayData).toList());
    final belongings = Belongings(pathData: dayData);

    return Center(
      child: Column(
        children: [
          Row(
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
              Text(dayData.selectedDate,
                  style: const TextStyle(color: Colors.black, fontSize: 32)),
              ElevatedButton(
                  onPressed: () {
                    debugPrint('日にちを増やす');
                  },
                  child: const Text('>')),
            ],
          ),
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
          // SubjectDropdown(pathData: data),
        ],
      ),
    );
  }
}

class Belongings extends ConsumerWidget {
  Belongings({super.key, required this.pathData});
  final DayBelongings pathData;
  // 選ばれたチェックボックスIDたち
  final checkedIdsProvider = StateProvider<Set<String>>((ref) {
    // 最初は空っぽ {}
    return {"0", "1", "2", "3"};
    // return {};
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // チェックボックスIDたち に合わせて画面を変化
    final checkedIds = ref.watch(checkedIdsProvider);

    // チェックボックスが押された時の関数
    void onChangedCheckbox(String id) {
      final newSet = Set.of(checkedIds);
      if (checkedIds.contains(id)) {
        newSet.remove(id);
      } else {
        newSet.add(id);
      }
      ref.read(checkedIdsProvider.notifier).state = newSet;
    }

    List<Widget> generatesItems(DayBelongings pathData) {
      List<Widget> items = [];
      for (int i = 0; i < pathData.itemNames.length; i++) {
        // onChangedCheckbox('$i');
        final item = CheckboxListTile(
            value: checkedIds.contains('$i'),
            onChanged: (check) => onChangedCheckbox('$i'), //checkBoxのID
            title: Text(
              pathData.itemNames[i],
              style: const TextStyle(fontSize: 32),
            ));
        items.add(item);
      }
      return items;
    }

    return Column(
      children: [
        SizedBox(
            width: 300,
            child: Column(
              children: generatesItems(pathData).toList(),
            )
            // child: col,
            ),
        // ElevatedButton(
        //   onPressed: () {
        //     // 選ばれたチェックボックスIDを確認する
        //     debugPrint(checkedIds.toString());
        //   },
        //   child: const Text('登録'),
        // ),
      ],
    );
  }
}
