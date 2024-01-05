import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:teacher/models/belongings.dart";

class Belongings extends ConsumerWidget {
  Belongings({super.key, required this.pathData});
  final DayBelongings pathData;
  final checkedItemsProvider = StateProvider<List<String>>((ref) {
    return ['ふでばこ', 'はしセット', 'うわばき', 'エプロン'];
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsTable = ['ふでばこ', 'はしセット', 'うわばき', 'エプロン'];
    final checkedItems = ref.watch(checkedItemsProvider);

    void onChangedCheckbox(String item) {
      final newSet = Set.of(checkedItems);
      if (checkedItems.contains(item)) {
        newSet.remove(item);
        // final sortedList = newSet.toList()..sort();
        // debugPrint('widget_belongings.dart #34 newSet; $sortedList');
        // final newSet2 = sortedList.map((e) => itemsTable[int.parse(e)]);

        // debugPrint('#39;${newSet2.toList()}');
        final newItems = pathData.copyWith(itemNames: newSet.toList());
        // debugPrint('#41;$newItems');
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      } else {
        newSet.add(item);
        // final sortedList = newSet.toList()..sort();
        // debugPrint('widget_belongings.dart #51 newSet; $sortedList');
        // final newSet2 = sortedList.map((e) => itemsTable[int.parse(e)]);
        // debugPrint('#54;${newSet2.toList()}');
        final newItems = pathData.copyWith(itemNames: newSet.toList());
        // debugPrint('#56;$newItems');
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      }
      ref.read(checkedItemsProvider.notifier).state = newSet.toList();
    }

    List<Widget> generatesItems(List itemsTable) {
      List<Widget> items = [];
      for (int i = 0; i < itemsTable.length; i++) {
        final item = CheckboxListTile(
            value: checkedItems.contains('${itemsTable[i]}'),
            onChanged: (check) => {
                  onChangedCheckbox('${itemsTable[i]}'), //checkBoxのID
                },
            title: Text(
              itemsTable[i],
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
              children: generatesItems(itemsTable).toList(),
            )),
      ],
    );
  }
}
