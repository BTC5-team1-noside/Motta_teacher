import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:teacher/models/belongings.dart";

class Belongings extends ConsumerWidget {
  Belongings({super.key, required this.pathData});
  final DayBelongings pathData;
  final checkedIdsProvider = StateProvider<Set<String>>((ref) {
    return {};
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsTable = ['ふでばこ', 'はしセット', 'うわばき', 'エプロン'];
    // チェックボックスIDたち に合わせて画面を変化
    Iterable<String> checkedIds = ref.watch(checkedIdsProvider);
    // debugPrint('widget_belongings_#22 : $checkedIds');
    debugPrint('widget_belongings_#23 : ${pathData.itemNames}');

    final List itemsId = [];
    for (int i = 0; i < pathData.itemNames.length; i++) {
      final item = switch (pathData.itemNames[i]) {
        "ふでばこ" => '0',
        "はしセット" => '1',
        "うわばき" => '2',
        "エプロン" => '3',
        String() => null,
      };
      itemsId.add(item);
    }
    debugPrint('widget_belongings_#39 : $itemsId');
    checkedIds = itemsId.map((e) => e.toString());
    debugPrint('widget_belongings_#42 : $checkedIds');

    ref.watch(dayBelongingsNotifierProvider);

    void onChangedCheckbox(String id) {
      final newSet = Set.of(checkedIds);
      if (checkedIds.contains(id)) {
        newSet.remove(id);
        final sortedList = newSet.toList()..sort();
        debugPrint('widget_belongings.dart #34 newSet; $sortedList');
        final newSet2 = sortedList.map((e) => itemsTable[int.parse(e)]);

        // debugPrint('#39;${newSet2.toList()}');
        final newItems = pathData.copyWith(itemNames: newSet2.toList());
        // debugPrint('#41;$newItems');
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      } else {
        newSet.add(id);
        final sortedList = newSet.toList()..sort();
        // debugPrint('widget_belongings.dart #51 newSet; $sortedList');
        final newSet2 = sortedList.map((e) => itemsTable[int.parse(e)]);
        // debugPrint('#54;${newSet2.toList()}');
        final newItems = pathData.copyWith(itemNames: newSet2.toList());
        // debugPrint('#56;$newItems');
        ref.read(dayBelongingsNotifierProvider.notifier).updateState(newItems);
      }
      ref.read(checkedIdsProvider.notifier).state = newSet;
    }

    List<Widget> generatesItems(List itemsTable) {
      List<Widget> items = [];
      for (int i = 0; i < itemsTable.length; i++) {
        final item = CheckboxListTile(
            value: checkedIds.contains('$i'),
            onChanged: (check) => {
                  debugPrint('#68 ;${itemsTable[i]}'),
                  onChangedCheckbox('$i'), //checkBoxのID
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
