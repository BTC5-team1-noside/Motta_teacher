import 'package:flutter/material.dart'; //必要
import 'package:flutter_riverpod/flutter_riverpod.dart'; //#9_rivepod_状態管理
// import 'package:go_router/go_router.dart'; //#11_g0_router_画面遷移
import 'package:flutter/foundation.dart'; //#13_BottomNavigationBar
import 'package:device_preview/device_preview.dart'; //#25_reponsive design
import 'package:teacher/screens/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

main() {
  // テーマの設定
  final theme = ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 245, 248, 251),
      appBarTheme:
          const AppBarTheme(backgroundColor: Color.fromARGB(255, 25, 112, 170)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 25, 112, 170)),
      visualDensity: VisualDensity.adaptivePlatformDensity);

  // MaterialAppのインスタンスを作成し、テーマを設定
  final app = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MainScreen(),
    theme: theme,
  );

  final scope = ProviderScope(child: app);
  initializeDateFormatting('ja_JP', null);

  if (kIsWeb) {
    final devicePreview = DevicePreview(builder: (_) => scope);
    runApp(devicePreview);
  } else {
    runApp(scope);
  }
}
