import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/belongings.dart';
import 'package:teacher/subject.dart';
import 'package:teacher/subject_2.dart';
import 'package:teacher/belongings_data.dart';
import 'package:intl/intl.dart';

class PageCheckList extends StatelessWidget {
  const PageCheckList({super.key});
  // late;

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
  Widget build(BuildContext context) {
    return FutureBuilder<DayBelongings>(
      future: getBelongingsApiData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データがまだ取得されていない場合の処理
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // エラーが発生した場合の処理
          return Text('Error: ${snapshot.error}');
        } else {
          // データが正常に取得された場合の処理
          final data = snapshot.data;

          final timetable = Column(children: generateTimeTable(data!).toList());
          final belongings = Belongings(pathData: data);

          return Scaffold(
              body: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          debugPrint('日にちを減らす');
                          debugPrint(data.selectedDate);
                          final timeF = DateTime.parse(data.selectedDate)
                              .add(const Duration(days: -1));
                          final f = DateFormat('yyyy-MM-dd');
                          final beforeDay = f.format(timeF);
                          debugPrint(beforeDay);
                          // final timeB = DateTime.parse(data.selectedDate);
                          // const durC = Duration(days: -1);
                          // final timeD = timeB.add(durC);
                        },
                        child: const Text('<')),
                    Text(data.selectedDate,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 32)),
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
                SubjectDropdown(pathData: data),
              ],
            ),
          ));
        }
      },
    );
  }
}

// // 選ばれたチェックボックスIDたち
// final checkedIdsProvider = StateProvider<Set<String>>((ref) {
//   // 最初は空っぽ {}
//   return {};
// });

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

//ドロップダウン選択で選べるように検討中=====================================
// //１時間目のドロップダウン
// class SubjectDropdown extends ConsumerWidget {
//   const SubjectDropdown({super.key, required this.pathData});
//   final DayBelongings pathData;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //今の選択されている授業科目
//     final subject = ref.watch(subject1NotifierProvider);

//     //授業の選択肢
//     final items = [
//       const DropdownMenuItem(
//         alignment: Alignment.center,
//         value: Subject1.japanese, //enum
//         child: Text('国語'), //表示するText
//       ),
//       const DropdownMenuItem(
//         value: Subject1.math, //enum
//         child: Text('算数'), //表示するText
//       ),
//       const DropdownMenuItem(
//         value: Subject1.science, //enum
//         child: Text('理科'), //表示するText
//       ),
//       const DropdownMenuItem(
//         value: Subject1.society, //enum
//         child: Text('社会'), //表示するText
//       ),
//       const DropdownMenuItem(
//         value: Subject1.english, //enum
//         child: Text('英語'), //表示するText
//       ),
//     ];
//     return SizedBox(
//         // fontSize: 38,
//         height: 100,
//         width: 200,
//         child: Row(
//           children: [
//             Text(
//               pathData.subjects[0].subject_name,
//               style: const TextStyle(fontSize: 32),
//             ),
//             DropdownButton(
//               style: const TextStyle(fontSize: 32),
//               // alignment: Alignment.center,
//               isExpanded: true,
//               value: subject,
//               items: items,
//               onChanged: (newSubject) {
//                 final notifier = ref.read(subject1NotifierProvider.notifier);
//                 debugPrint('nweSubject : $newSubject');
//                 notifier.updateSubject(newSubject!);
//               },
//             )
//           ],
//         ));
//   }
// }

class SubjectDropdown extends StatefulWidget {
  const SubjectDropdown({super.key, required this.pathData});
  final DayBelongings pathData;
  // String data;
  @override
  State<SubjectDropdown> createState() => _SubjectDropdownState();
}

class _SubjectDropdownState extends State<SubjectDropdown> {
  late DayBelongings _pathData;
  String subject = "";
  String _data = "";
  @override
  void initState() {
    super.initState();
    _pathData = widget.pathData;
    subject = _pathData.subjects[0].subject_name;
    _data = subject;
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      const DropdownMenuItem(
        // alignment: Alignment.center,
        value: "こくご", //enum
        child: Text(
          '国語',
          style: TextStyle(color: Colors.black),
        ), //表示するText
      ),
      const DropdownMenuItem(
        value: "さんすう", //enum
        child: Text(
          '算数',
          style: TextStyle(color: Colors.black),
        ), //表示するText
      ),
      const DropdownMenuItem(
        value: "りか", //enum
        child: Text(
          '理科',
          style: TextStyle(color: Colors.black),
        ), //表示するText
      ),
      const DropdownMenuItem(
        value: "しゃかい", //enum
        child: Text(
          '社会',
          style: TextStyle(color: Colors.black),
        ), //表示するText
      ),
      const DropdownMenuItem(
        value: " えいご", //enum
        child: Text(
          '英語',
          style: TextStyle(color: Colors.black),
        ), //表示するText
      ),
    ];

    return Row(
      children: [
        Text(
          subject,
          style: const TextStyle(fontSize: 32),
        ),
        SizedBox(
            // fontSize: 38,
            height: 100,
            width: 200,
            child: DropdownButton(
              style: const TextStyle(fontSize: 32),
              // alignment: Alignment.center,
              isExpanded: true,
              value: subject,
              items: items,
              onChanged: (newSubject) {
                debugPrint("$newSubject");
                setState(() {
                  subject = newSubject!;
                  _data = subject;
                });
                // final notifier = ref.read(subject1NotifierProvider.notifier);
                // debugPrint('nweSubject : $newSubject');
                // notifier.updateSubject(newSubject!);
              },
            )),
      ],
    );
  }
}

//時間割の２時間目のドロップダウン
class SubjectDropdown2 extends ConsumerWidget {
  const SubjectDropdown2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //今の選択されている授業科目
    final subject = ref.watch(subjectNotifier2Provider);

    //授業の選択肢
    final items = [
      const DropdownMenuItem(
        alignment: Alignment.center,
        value: Subject2.japanese, //enum
        child: Text('国語'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject2.math, //enum
        child: Text('算数'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject2.science, //enum
        child: Text('理科'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject2.society, //enum
        child: Text('社会'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject2.english, //enum
        child: Text('英語'), //表示するText
      ),
    ];

    return SizedBox(
        // fontSize: 38,
        height: 100,
        width: 200,
        child: DropdownButton(
          style: const TextStyle(fontSize: 32),
          // alignment: Alignment.center,
          isExpanded: true,
          value: subject,
          items: items,
          onChanged: (newSubject) {
            final notifier = ref.read(subjectNotifier2Provider.notifier);
            notifier.updateSubject(newSubject!);
          },
        ));
  }
}
//ドロップダウン選択で選べるように検討中=====================================
