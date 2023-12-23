import 'package:flutter/material.dart'; //必要
import 'package:flutter_riverpod/flutter_riverpod.dart'; //#9_rivepod_状態管理
// import 'package:go_router/go_router.dart'; //#11_g0_router_画面遷移
// import 'package:flutter/foundation.dart'; //#13_BottomNavigationBar
// import 'package:device_preview/device_preview.dart'; //#25_reponsive design

import 'package:teacher/page_Home.dart';
import 'package:teacher/page_check_list.dart';
import 'package:teacher/page_setting.dart';

// BottomNavの初期設定
final indexProvider = StateProvider((ref) {
  return 0;
});

//BottomNavの状態管理（選択した画面へ移動）
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = ref.watch(indexProvider);
    //アップバー
    final appBar = makeAppBar();

    // フローティングアクションボタン (FAB)
    final fab = FloatingActionButton(
      onPressed: () {
        ref.read(indexProvider.notifier).state = 1;
        // debugPrint('FAB が押されました');
      },
      child:
          const Icon(Icons.fact_check), // label: '持ち物登録'//const Text('持ち物登録'),
    );

    //ボトムバー
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: '持ち物登録'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
    ];

    final bar = BottomNavigationBar(
      items: items,
      unselectedFontSize: 18,
      selectedFontSize: 25,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey.shade300,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );

    final pages = [
      const PageHome(),
      const PageCheckList(),
      const PageSettings()
    ];

    return Scaffold(
      appBar: appBar,
      floatingActionButton: fab, // フローティングアクションボタン (FAB)
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }

  AppBar makeAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 50),
      title: const Text('Motta'),
    );
  }
}
