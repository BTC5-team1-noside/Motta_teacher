import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            '生徒登録',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            //実行したい関数を設定
            debugPrint('Tap on list tile A');
          },
        ),
        ListTile(
          title: const Text(
            '時間割　編集',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            debugPrint('Tap on list tile B');
          },
        ),
        ListTile(
          title: const Text(
            '日常品　編集',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            debugPrint('Tap on list tile C');
          },
        ),
        ListTile(
          title: const Text(
            'カレンダー登録',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          onTap: () {
            debugPrint('Tap on list tile D');
          },
        ),
      ],
    );
  }
}
