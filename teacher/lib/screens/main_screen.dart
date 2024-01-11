// import 'package:go_router/go_router.dart'; //#11_g0_router_画面遷移
// import 'package:flutter/foundation.dart'; //#13_BottomNavigationBar
// import 'package:device_preview/device_preview.dart'; //#25_reponsive design
import 'package:flutter/material.dart'; //必要
import 'package:teacher/models/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; //#9_rivepod_状態管理
import 'package:teacher/screens/page_home.dart';
// import 'package:teacher/page_check_list.dart';
import 'package:teacher/screens/page_check_list.dart';
import 'package:teacher/screens/page_setting.dart';
// import 'package:teacher/models/belongings.dart';

//BottomNavの状態管理（選択した画面へ移動）
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = ref.watch(indexNotifierProvider);

    //アップバー
    final appBar = makeAppBar();

    //ボトムバー
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
      BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: '持ち物登録'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
    ];

    final bar = BottomNavigationBar(
      items: items,
      unselectedFontSize: 16,
      selectedFontSize: 16,
      // backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey.shade300,
      currentIndex: index,
      onTap: (idx) {
        ref.read(indexNotifierProvider.notifier).updateState(idx);
      },
    );

    final pages = [
      PageHome(),
      PageCheckList(),
      const PageSettings(),
    ];

    return Scaffold(
      appBar: appBar,
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }

  AppBar makeAppBar() {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Motta_logo.png',
            height: 60,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
