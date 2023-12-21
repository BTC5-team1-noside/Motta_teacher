import 'package:flutter/material.dart';
import 'package:teacher/side_menu.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      Container(
        width: 300, // サイドメニューの幅
        color: Colors.white,
        child: const SideMenu(),
      ),
      const Center(
        child: Text(
          "SAMPLE TEXT",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      )
    ]));
  }
}
