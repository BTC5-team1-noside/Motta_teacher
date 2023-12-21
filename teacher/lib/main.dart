import 'package:flutter/material.dart'; //必要
import 'package:flutter_riverpod/flutter_riverpod.dart'; //#9_rivepod_状態管理
import 'package:go_router/go_router.dart'; //#11_g0_router_画面遷移
import 'package:flutter/foundation.dart'; //#13_BottomNavigationBar
import 'package:device_preview/device_preview.dart'; //#25_reponsive design
import 'package:teacher/main_screen.dart';

import 'package:teacher/page_Home.dart';
import 'package:teacher/page_check_list.dart';
// import 'package:teacher/page_setting.dart';
// import 'package:teacher/side_menu.dart';
//gitレポジトリ移動後の動作確認

main() {
  // 画面
  // final goRote = goRouterFromCalender();

  // // const scaffold = Scaffold(
  // //   body: MainScreen(),
  // );

  // アプリ
  // const app = MaterialApp(home: scaffold);
  const app = MaterialApp(
      home:
          // goRouterFromCalender()
          MainScreen());
  // プロバイダースコープでアプリを囲む
  const scope = ProviderScope(child: app);

  if (kIsWeb) {
    final devicePreview = DevicePreview(builder: (_) => scope);
    runApp(devicePreview);
  } else {
    runApp(scope);
  }
}

//下記だとカレンダーから画面遷移できるけど、scaffoldが読み込めていない
// main() {
//   final app = MaterialApp(home: goRouterFromCalender());

//   final scope = ProviderScope(child: app);

//   if (kIsWeb) {
//     final devicePreview = DevicePreview(builder: (_) => scope);
//     runApp(devicePreview);
//   } else {
//     runApp(scope);
//   }
// }

// カレンダーから画面遷移
class goRouterFromCalender extends StatelessWidget {
  goRouterFromCalender({super.key});

  final router = GoRouter(
    // パス (アプリが起動したとき)
    initialLocation: '/b',
    // パスと画面の組み合わせ
    routes: [
      GoRoute(
        path: '/a',
        builder: (context, state) => const PageCheckList(),
      ),
      GoRoute(
        path: '/b',
        builder: (context, state) => const PageHome(),
      ),
      //   GoRoute(
      //     path: '/c',
      //     builder: (context, state) => const PageC(),
      //   ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
