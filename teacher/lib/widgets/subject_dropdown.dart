import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class SubjectDropdown extends ConsumerWidget {
  const SubjectDropdown(this.period, {super.key});

  final int period;

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
        value: "たいいく",
        child: Text('たいいく'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'せいかつ', //enum
        child: Text('せいかつ'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: "おんがく", //enum
        child: Text('おんがく'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'がっかつ', //enum
        child: Text('がっかつ'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'どうとく', //enum
        child: Text('どうとく'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'としょ', //enum
        child: Text('としょ'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'ずこう', //enum
        child: Text('ずこう'), //表示するText
      ),
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: 'じゅぎょう　なし', //enum
        child: Text('授業なし'), //表示するText
      ),
    ];

    return DropdownButton(
      style: const TextStyle(fontSize: 26),
      // alignment: Alignment.center,
      isExpanded: true,
      value: dayData.subjects[period].subject_name,
      items: items,
      onChanged: (newSubject) async {
        final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
            'api/v1/teacher/settings/belongings');
        try {
          //JSON <=== from API(Database)
          final response = await http.get(url);
          //JsonMAP <=== JSON
          final belongingsBySubject = json.decode(response.body);
          final data = belongingsBySubject
              .where((ele) => ele["subject_name"] == newSubject)
              .toList();
          debugPrint('#89 data;$data');
          late Subject newSub;
          if (data.isNotEmpty) {
            List<String> listString = (data[0]["belongings"] as List<dynamic>)
                .map((item) => item as String)
                .toList();

            newSub = dayData.subjects[period]
                .copyWith(subject_name: newSubject!, belongings: listString);
          } else if (data.isEmpty) {
            newSub = dayData.subjects[period]
                .copyWith(subject_name: newSubject!, belongings: []);
          }

          List<Subject> newSubjects = [...dayData.subjects];
          newSubjects[period] = newSub;

          DayBelongings newSet = dayData.copyWith(subjects: newSubjects);

          final notifier = ref.read(dayBelongingsNotifierProvider.notifier);
          notifier.updateState(newSet);
          debugPrint("subject_dropdown #97; $newSet");
        } catch (error) {
          debugPrint(error.toString());
          throw Exception('Failed to load data: $error');
        }
      },
    );
  }
}
