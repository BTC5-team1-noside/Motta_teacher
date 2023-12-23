import 'package:flutter/material.dart'; //必要
import 'package:flutter_riverpod/flutter_riverpod.dart'; //#9_rivepod_状態管理
// import 'package:go_router/go_router.dart'; //#11_g0_router_画面遷移
import 'package:flutter/foundation.dart'; //#13_BottomNavigationBar
import 'package:device_preview/device_preview.dart'; //#25_reponsive design
import 'package:teacher/main_screen.dart';
import 'package:http/http.dart' as http; //エンドポイントからJSONマップを取得できる

main() {
  const app = MaterialApp(home: MainScreen());
  // プロバイダースコープでアプリを囲む
  const scope = ProviderScope(child: app);

  if (kIsWeb) {
    final devicePreview = DevicePreview(builder: (_) => scope);
    runApp(devicePreview);
  } else {
    runApp(scope);
  }
}
