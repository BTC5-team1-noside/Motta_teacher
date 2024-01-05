import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:teacher/models/belongings.dart";

class Belongings extends ConsumerWidget {
  Belongings({super.key, required this.pathData});
  final DayBelongings pathData;
  final checkedItemsProvider = StateProvider<List<String>>((ref) {
    return ['ふでばこ', 'はしセット', 'うわばき', 'エプロン'];
    // return [];
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsTable = ['ふでばこ', 'はしセット', 'うわばき', 'エプロン'];
    var checkedItems = ref.watch(checkedItemsProvider);
    debugPrint('#16${pathData.itemNames}');
    // ref.read(checkedItemsProvider.notifier).state = pathData.itemNames;
    // // checkedItems.copyWith(pathData.itemNames);
    //❗️おそらくココ。
    debugPrint('#15$checkedItems');
    void onChangedCheckbox(String item) {
      final newSet = Set.of(checkedItems);
      if (checkedItems.contains(item)) {
        debugPrint('#19$newSet');
        newSet.remove(item);
        checkedItems.remove(item);
        debugPrint('#21$newSet');
        debugPrint('#22$checkedItems');
        // final sortedList = newSet.toList()..sort();
        // debugPrint('widget_belongings.dart #34 newSet; $sortedList');
        // final newSet2 = sortedList.map((e) => itemsTable[int.parse(e)]);

        // debugPrint('#39;${newSet2.toList()}');
        final newItems = pathData.copyWith(itemNames: newSet.toList());
        debugPrint('#28;$newItems');
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      } else {
        newSet.add(item);
        checkedItems.add(item);
        debugPrint('#36$newSet');
        debugPrint('#37$checkedItems');
        // final sortedList = newSet.toList()..sort();
        // debugPrint('widget_belongings.dart #51 newSet; $sortedList');
        // final newSet2 = sortedList.map((e) => itemsTable[int.parse(e)]);
        // debugPrint('#54;${newSet2.toList()}');
        final newItems = pathData.copyWith(itemNames: newSet.toList());
        // debugPrint('#56;$newItems');
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      }
      debugPrint('#41${checkedItems.toList()}');
      ref.read(checkedItemsProvider.notifier).state = checkedItems.toList();
    }

    List<Widget> generatesItems(List itemsTable, List checkedItems) {
      List<Widget> items = [];
      for (int i = 0; i < itemsTable.length; i++) {
        final item = CheckboxListTile(
            value: checkedItems.contains('${checkedItems[i]}'),
            onChanged: (check) => {
                  debugPrint('refactaring #47${itemsTable[i]}'),
                  debugPrint(
                      '#51 ${checkedItems.contains('${checkedItems[i]}')}'),
                  onChangedCheckbox('${checkedItems[i]}'), //checkBoxのID
                },
            title: Text(
              itemsTable[i],
              style: const TextStyle(fontSize: 32),
            ));
        items.add(item);
      }
      return items;
    }

    debugPrint('#70$checkedItems');
    return Column(
      children: [
        SizedBox(
            width: 300,
            child: Column(
              children: generatesItems(itemsTable, checkedItems).toList(),
            )),
      ],
    );
  }
}
