import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:teacher/subject.dart';
import 'package:teacher/models/edit_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/edit_settings.dart';

class SideMenu extends ConsumerWidget {
  SideMenu({Key? key}) : super(key: key);

  late int pageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageId = ref.watch(editScreenNotifierProvider);

    return Container(
      color: const Color.fromARGB(255, 34, 38, 49).withOpacity(0.9),
      child: ListView(
        children: [
          buildListTile(ref, pageId, 0, '生徒編集', Icons.group),
          buildListTile(ref, pageId, 1, '時間割 編集', Icons.dataset),
          buildListTile(ref, pageId, 2, '科目別 持ち物編集', Icons.square_foot),
          buildListTile(ref, pageId, 3, '日常品 編集', Icons.edit),
          buildListTile(ref, pageId, 4, 'イベント登録', Icons.event),
        ],
      ),
    );
  }

  Widget buildListTile(WidgetRef ref, int currentPageId, int tilePageId,
      String title, IconData icon) {
    bool isSelected = currentPageId == tilePageId;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          pageId = tilePageId;
          final notifier = ref.read(editScreenNotifierProvider.notifier);
          notifier.updateScreen(pageId);
          debugPrint('Tap on list tile $title:$pageId');
        },
        hoverColor: const Color.fromARGB(255, 34, 38, 49),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          tileColor: isSelected
              ? const Color.fromARGB(255, 2, 37, 49) // 選択されたアイテムの色
              : null, // デフォルトの色にするためにnullを使用
          title: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
