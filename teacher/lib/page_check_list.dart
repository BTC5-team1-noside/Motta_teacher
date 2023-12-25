import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/subject.dart';
import 'package:teacher/subject_2.dart';
import 'package:http/http.dart' as http; //エンドポイントからJSONマップを取得できる
// SubjectNotifier2

class PageCheckList extends StatelessWidget {
  const PageCheckList({super.key});

  List<Widget> generateRows() {
    List<Widget> rows = [];
    for (int i = 1; i < 6; i++) {
      final row = Row(
        children: [
          Text(
            "$i時間目: ",
            style: const TextStyle(color: Colors.black, fontSize: 32),
          ),
          const SubjectDropdown(),
          const SubjectDropdown2(),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    const timetable = Column(
      // children: generateRows().toList(),
      children: [
        Row(children: [
          Text(
            "1時間目: ",
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
          SubjectDropdown(),
        ]),
        Row(children: [
          Text(
            "2時間目: ",
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
          SubjectDropdown2(),
        ]),
      ],
    );
    const belongings = Belongings();
    return const Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timetable,
          belongings,
        ],
      ),
      // ],
    )
        // ),
        );
  }
}

class SubjectDropdown extends ConsumerWidget {
  const SubjectDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //今の選択されている授業科目
    final subject = ref.watch(subjectNotifierProvider);

    //授業の選択肢
    final items = [
      const DropdownMenuItem(
        alignment: Alignment.center,
        value: Subject.japanese, //enum
        child: Text('国語'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject.math, //enum
        child: Text('算数'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject.science, //enum
        child: Text('理科'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject.society, //enum
        child: Text('社会'), //表示するText
      ),
      const DropdownMenuItem(
        value: Subject.english, //enum
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
            final notifier = ref.read(subjectNotifierProvider.notifier);
            notifier.updateSubject(newSubject!);
          },
        ));
  }
}

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

// 選ばれたチェックボックスIDたち
final checkedIdsProvider = StateProvider<Set<String>>((ref) {
  // 最初は空っぽ {}
  return {};
});

class Belongings extends ConsumerWidget {
  const Belongings({super.key});

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

    final col = Column(children: [
      CheckboxListTile(
        onChanged: (check) => onChangedCheckbox('A'), //checkBoxのID
        value: checkedIds.contains('A'), //checkBoxのID
        title: const Text(
          '箸入れ',
          style: TextStyle(fontSize: 32),
        ),
      ),

      CheckboxListTile(
        onChanged: (check) => onChangedCheckbox('B'),
        value: checkedIds.contains('B'),
        title: const Text(
          '上靴',
          style: TextStyle(fontSize: 32),
        ),
      ),

      CheckboxListTile(
        onChanged: (check) => onChangedCheckbox('C'),
        value: checkedIds.contains('C'),
        title: const Text(
          'エプロン',
          style: TextStyle(fontSize: 32),
        ),
      ),
      // OK ボタン

      ElevatedButton(
        onPressed: () {
          // // 選ばれたラジオボタンIDを確認する
          // debugPrint(radioId);
          // 選ばれたチェックボックスIDを確認する
          debugPrint(checkedIds.toString());
        },
        child: const Text('登録'),
      ),
    ]);
    return SizedBox(
      width: 300,
      child: col,
    );
  }
}
