import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:teacher/models/belongings.dart";

class Belongings extends ConsumerWidget {
  Belongings({super.key, required this.pathData});
  final DayBelongings pathData;
  // final checkedItemsProvider = StateProvider<Set<String>>((ref) {
  //   return {'ふでばこ', 'はしセット', 'うわばき', 'エプロン'};
  // });
  final itemsTable = ['ふでばこ', 'はしセット', 'うわばき', 'エプロン'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var checkedItems = ref.watch(checkedItemsProvider);
    // checkedItems = pathData.itemNames.toSet();
    final checkedItems = pathData.itemNames.toSet();
    ref.watch(dayBelongingsNotifierProvider);

    void onChangedCheckbox(String item) {
      final newSet = Set.of(checkedItems);
      if (checkedItems.contains(item)) {
        newSet.remove(item);
        final newItems = pathData.copyWith(itemNames: newSet.toList());
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      } else {
        newSet.add(item);
        final newItems = pathData.copyWith(itemNames: newSet.toList());
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      }
      // ref.read(checkedItemsProvider.notifier).state = checkedItems;
    }

    List<Widget> generatesItems(List itemsTable, List checkedItems) {
      List<Widget> items = [];
      for (int i = 0; i < itemsTable.length; i++) {
        final item = CheckboxListTile(
            value: checkedItems.contains('${itemsTable[i]}'),
            onChanged: (check) => {
                  onChangedCheckbox('${itemsTable[i]}'),
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
              children:
                  generatesItems(itemsTable, checkedItems.toList()).toList(),
            )),
      ],
    );
  }
}
