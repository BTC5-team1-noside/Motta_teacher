import 'package:flutter/material.dart'; //必要
import 'package:flutter_riverpod/flutter_riverpod.dart'; //#9_rivepod_状態管理
// import 'package:go_router/go_router.dart'; //#11_g0_router_画面遷移
import 'package:flutter/foundation.dart'; //#13_BottomNavigationBar
import 'package:device_preview/device_preview.dart'; //#25_reponsive design
import 'package:teacher/screens/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

main() {
  // ネイビーブルーとクリームホワイト
  Color navyBlue = const Color.fromARGB(0xFF, 0x00, 0x1F, 0x3F); // #FF001F3F
  Color creamWhite = const Color.fromARGB(0xFF, 0xFD, 0xFB, 0xF4); // #FFFDFBF4

// オリーブグリーンとサンドベージュ
  Color oliveGreen = const Color.fromARGB(0xFF, 0x55, 0x6B, 0x2F); // #FF556B2F
  Color sandBeige = const Color.fromARGB(0xFF, 0xF5, 0xEC, 0xD2); // #FFF5ECD2

// チャコールグレーとライトグレー
  Color charcoalGrey =
      const Color.fromARGB(0xFF, 0x33, 0x33, 0x33); // #FF333333
  Color lightGrey = const Color.fromARGB(0xFF, 0xD3, 0xD3, 0xD3); // #FFD3D3D3

// ワインレッドとチャンピオンゴールド
  Color wineRed = const Color.fromARGB(0xFF, 0x8E, 0x35, 0x4A); // #FF8E354A
  Color championGold =
      const Color.fromARGB(0xFF, 0xDA, 0xA5, 0x20); // #FFDAA520

// スティールブルーとミストグレー
  Color steelBlue = const Color.fromARGB(0xFF, 0x46, 0x82, 0xB4); // #FF4682B4
  Color mistGrey = const Color.fromARGB(0xFF, 0xE6, 0xE6, 0xFA); // #FFE6E6FA

// ディープグリーンとアイボリー
  Color deepGreen = const Color.fromARGB(0xFF, 0x00, 0x56, 0x3F); // #FF00563F
  Color ivory = const Color.fromARGB(0xFF, 0xFF, 0xFF, 0xF0); // #FFFFFFF0

// ブルーグレーとシルバー
  Color blueGrey = const Color.fromARGB(0xFF, 0x66, 0x99, 0xCC); // #FF6699CC
  Color silver = const Color.fromARGB(0xFF, 0xC0, 0xC0, 0xC0); // #FFC0C0C0

// モスグリーンとベージュ
  Color mossGreen = const Color.fromARGB(0xFF, 0x8A, 0x9A, 0x5B); // #FF8A9A5B
  Color beige = const Color.fromARGB(0xFF, 0xF5, 0xF5, 0xDC); // #FFF5F5DC

// ダスティローズとライトブラウン
  Color dustyRose = const Color.fromARGB(0xFF, 0xDA, 0xA5, 0x20); // #FFDAA520
  Color lightBrown = const Color.fromARGB(0xFF, 0xD2, 0xB4, 0x8C); // #FFD2B48C

// シーフォームグリーンとペールイエロー
  Color seafoamGreen =
      const Color.fromARGB(0xFF, 0x71, 0xC6, 0x71); // #FF71C671
  Color paleYellow = const Color.fromARGB(0xFF, 0xF0, 0xE6, 0x8C); // #FFF0E68C

// スレートグレーとミントグリーン
  Color slateGrey = const Color.fromARGB(0xFF, 0x70, 0x80, 0x90); // #FF708090
  Color mintGreen = const Color.fromARGB(0xFF, 0x98, 0xFB, 0x98); // #FF98FB98

// ダークプラムとシルバーブルー
  Color darkPlum = const Color.fromARGB(0xFF, 0x58, 0x35, 0x5E); // #FF58355E
  Color silverBlue = const Color.fromARGB(0xFF, 0x46, 0x82, 0xB4); // #FF4682B4

// チョコレートブラウンとチャコールブルー
  Color chocolateBrown =
      const Color.fromARGB(0xFF, 0xD2, 0x69, 0x1E); // #FFD2691E
  Color charcoalBlue =
      const Color.fromARGB(0xFF, 0x36, 0x45, 0x4F); // #FF36454F

// アッシュグレーとライラックパープル
  Color ashGrey = const Color.fromARGB(0xFF, 0xB2, 0xBE, 0xB5); // #FFB2BEB5
  Color lilacPurple = const Color.fromARGB(0xFF, 0x94, 0x70, 0xDB); // #FF9470DB

// コーラルピンクとネイビーグレー
  Color coralPink = const Color.fromARGB(0xFF, 0xFF, 0x6F, 0x61); // #FFFF6F61
  Color navyGrey = const Color.fromARGB(0xFF, 0x5A, 0x5A, 0x6F); // #FF5A5A6F

// アイスブルーとペールローズ
  Color iceBlue = const Color.fromARGB(0xFF, 0x71, 0xA6, 0xD2); // #FF71A6D2
  Color paleRose = const Color.fromARGB(0xFF, 0xFA, 0xD6, 0xE5); // #FFFAD6E5

// オリエンタルレッドとサンドストーン
  Color orientalRed = const Color.fromARGB(0xFF, 0xF5, 0x3B, 0x3B); // #FFF53B3B
  Color sandstone = const Color.fromARGB(0xFF, 0xDD, 0xB7, 0x6E); // #FFDDB76E

// ペタルピンクとペールグレイ
  Color petalPink = const Color.fromARGB(0xFF, 0xF8, 0x83, 0x79); // #FFF88379
  Color paleGrey = const Color.fromARGB(0xFF, 0xD3, 0xD3, 0xD3); // #FFD3D3D3

// アースブラウンとミントクリーム
  Color earthBrown = const Color.fromARGB(0xFF, 0x8B, 0x45, 0x13); // #FF8B4513
  Color mintCream = const Color.fromARGB(0xFF, 0x98, 0xFB, 0x98); // #FF98FB98

// セピアブラウンとペールターコイズ
  Color sepiaBrown = const Color.fromARGB(0xFF, 0x70, 0x42, 0x14); // #FF704214
  Color paleTurquoise =
      const Color.fromARGB(0xFF, 0xAF, 0xEE, 0xEE); // #FFAFEEEE

  final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.amber,
          // scaffoldBackgroundColor: const Color.fromARGB(255, 236, 236, 236),
          scaffoldBackgroundColor: silverBlue,
          appBarTheme: AppBarTheme(
              // backgroundColor: Colors.blue,
              backgroundColor: darkPlum,
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 50)),
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.blue)),
      home: const MainScreen());
  // プロバイダースコープでアプリを囲む

  final scope = ProviderScope(child: app);
  initializeDateFormatting('ja_JP', null);

  if (kIsWeb) {
    final devicePreview = DevicePreview(builder: (_) => scope);
    runApp(devicePreview);
  } else {
    runApp(scope);
  }
}
