import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:teacher/models/belongings.dart";

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
