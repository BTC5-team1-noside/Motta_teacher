import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:teacher/subject.dart';
import 'package:teacher/edit_settings.dart';

// class SideMenu extends StatelessWidget {
class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageId = ref.watch(editScreenNotifierProvider);
    // debugPrint('here is side_menu;pageId=$pageId');

    return ListView(
      // padding: const EdgeInsets.all(100),
      children: [
        ListTile(
          selectedTileColor: Colors.grey.shade400,
          // titleTextStyle: ,
          title: const Text(
            '生徒編集',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            //実行したい関数を設定
            pageId = 0;
            final notifier = ref.read(editScreenNotifierProvider.notifier);
            notifier.updateScreen(pageId);
            debugPrint('Tap on list tile A:$pageId');
          },
        ),
        ListTile(
          title: const Text(
            '時間割　編集',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            pageId = 1;
            final notifier = ref.read(editScreenNotifierProvider.notifier);
            notifier.updateScreen(pageId);
            debugPrint('Tap on list tile B');
          },
        ),
        ListTile(
          title: const Text(
            '科目別　持ち物編集',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            pageId = 2;
            final notifier = ref.read(editScreenNotifierProvider.notifier);
            notifier.updateScreen(pageId);
            debugPrint('Tap on list tile C');
          },
        ),
        ListTile(
          title: const Text(
            '日常品　編集',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            pageId = 3;
            final notifier = ref.read(editScreenNotifierProvider.notifier);
            notifier.updateScreen(pageId);
            debugPrint('Tap on list tile C');
          },
        ),
        ListTile(
          title: const Text(
            'イベント登録',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            pageId = 4;
            final notifier = ref.read(editScreenNotifierProvider.notifier);
            notifier.updateScreen(pageId);
            debugPrint('Tap on list tile D');
          },
        ),
      ],
    );
  }
}
