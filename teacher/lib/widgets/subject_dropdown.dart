import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import 'package:teacher/models/subject.dart';

class SubjectDropdown extends ConsumerWidget {
  const SubjectDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayBelongings dayData = ref.watch(dayBelongingsNotifierProvider);
    //今の選択されている授業科目
    // final subject = ref.watch(subject1NotifierProvider);

    //授業の選択肢
    final items = [
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: "こくご",
        child: Text('こくご'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: "さんすう",
        child: Text('さんすう'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: "りか", //enum
        child: Text('りか'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'しゃかい', //enum
        child: Text('しゃかい'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'えいご', //enum
        child: Text('えいご'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'せいかつ', //enum
        child: Text('せいかつ'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'どうとく', //enum
        child: Text('どうとく'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'ずこう', //enum
        child: Text('ずこう'), //表示するText
      ),
    ];

    return DropdownButton(
      style: const TextStyle(fontSize: 32),
      // alignment: Alignment.center,
      isExpanded: true,
      value: dayData.subjects[0].subject_name,
      items: items,
      onChanged: (newSubject) {
        DayBelongings newSet = dayData.copyWith();
        debugPrint("$newSet");
      },
    );
  }
}
