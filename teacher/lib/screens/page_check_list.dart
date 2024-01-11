import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import 'package:teacher/models/index.dart';
import 'package:teacher/widgets/belongings_data.dart';
import 'package:intl/intl.dart';
// import "package:teacher/models/date.dart";
// import "package:teacher/widgets/belongings.dart";
import 'package:teacher/widgets/belonging_refactaring.dart';
import 'package:teacher/widgets/subject_dropdown.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class PageCheckList extends ConsumerWidget {
  PageCheckList({super.key});

  //時間割のテキスト・ドロップダウンの初期設定
  List<Widget> generateTimeTable(DayBelongings pathData) {
    List<Widget> rows = [];
    for (int i = 0; i < pathData.subjects.length; i++) {
      final row = Row(
        children: [
          Text(
            "${i + 1}時間目: ",
            style: const TextStyle(color: Colors.black, fontSize: 32),
          ),
          SizedBox(width: 160, child: SubjectDropdown(i)),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  //追加の持ち物の初期設定❗️バグあり見直し中❗️
  List<String> generateAdditionalItems(DayBelongings pathData) {
    List<String> additionalItems = [];
    if (pathData.isHistoryData) {
      for (int i = 0; i < pathData.additionalItemNames.length; i++) {
        if (pathData.additionalItemNames[i].isNotEmpty) {
          additionalItems.add(pathData.additionalItemNames[i]);
        } else {
          additionalItems.add('');
        }
      }
    } else {
      //変更保存されていないと、再描画の時に入力した内容が消えてしまう❗️
      additionalItems = List.filled(6, "");
      for (int i = 0; i < pathData.additionalItemNames.length; i++) {
        if (pathData.additionalItemNames[i].isNotEmpty) {
          additionalItems[i] = pathData.additionalItemNames[i];
        }
      }
    }
    return additionalItems;
  }
  //追加の持ち物の初期設定❗️バグあり見直し中❗️

  //追加の持ち物のTextFeildのフォーカスを管理する変数の初期化
  final List<FocusNode> focusNods = [];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("page_check_list:START");

    //持ち物データの状態管理
    final DayBelongings dayData = ref.watch(dayBelongingsNotifierProvider);

    //追加の持ち物を格納する変数/❗️バグあり見直し中❗️
    var additionalItems = generateAdditionalItems(dayData);

    final List<TextEditingController> itemTextControllers = [];
    const additionalNum = 6; //追加の持ち物の表示Textの数

    //曜日表示を格納した変数
    final timeF = DateTime.parse(dayData.selectedDate);
    final day = '日月火水木金土日'[timeF.weekday];

    late List<Widget> registerMain;
    late Widget timetable;
    late Widget belongings;

    //新規登録・変更保存の表示切り替えをするText
    final String updateButtonText = dayData.isHistoryData ? '変更保存' : '新規登録';

    //追加の持ち物のTextFeildのフォーカスを管理する変数の初期化
    //❓初期化はこの場所で良いか再確認❓
    for (int i = 0; i < additionalNum; i++) {
      focusNods.add(FocusNode());
    }

    //追加の持ち物のTextFeildのフォーカスを管理するFocusNodeに
    //フォーカスが変更されたときに呼び出す処理を設定
    //❓初期化はこの場所で良いか再確認❓
    void textFeildFocusController(int i) {
      focusNods[i].addListener(() {
        // フォーカスが離れたときの処理
        if (!focusNods[i].hasFocus) {
          debugPrint('Focus lost $i');

          //入力された追加の持ち物を状態管理へ反映させ、再描画
          DayBelongings newSet =
              dayData.copyWith(additionalItemNames: additionalItems);
          ref.read(dayBelongingsNotifierProvider.notifier).updateState(newSet);
          debugPrint('#99 newSet; $newSet');
        }
      });
    }

    //追加の持ち物のTextFieldの初期設定
    for (int i = 0; i < additionalNum; i++) {
      itemTextControllers.add(TextEditingController());
      textFeildFocusController(i);
    }

    //追加の持ち物のTextFieldにデータベースの情報を反映
    for (int i = 0; i < dayData.additionalItemNames.length; i++) {
      itemTextControllers[i].text = dayData.additionalItemNames[i];
    }

    //時間割・日常品の持ち物の表示するWidgetを格納した配列
    if (dayData.subjects.isEmpty) {
      registerMain = [
        timetable = const Text(
          "この日は授業が\nありません。",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50),
        ),
      ];
    } else {
      registerMain = [
        timetable = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: generateTimeTable(dayData).toList()),
        belongings = Belongings(pathData: dayData)
      ];
    }

    //前後に移動した日にちの持ち物登録画面へ変更
    void toChangeDate(DayBelongings dayData, int value) async {
      final time =
          DateTime.parse(dayData.selectedDate).add(Duration(days: value));
      final changingDate = DateFormat('yyyy-MM-dd').format(time);
      final DayBelongings data = await getBelongingsApiData(date: changingDate);
      ref.read(dayBelongingsNotifierProvider.notifier).updateState(data);
    }

    debugPrint('#178 ; ${dayData.additionalItemNames}');

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        //日にち表示（　＜　日付（曜日）　＞　）
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  toChangeDate(dayData, -1);
                },
                child: const Text('<')),
            const SizedBox(
              width: 50,
            ),
            Text("${dayData.selectedDate} ($day)",
                style: const TextStyle(color: Colors.black, fontSize: 32)),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  toChangeDate(dayData, 1);
                },
                child: const Text('>')),
          ],
        ),
        const SizedBox(height: 50),
        //時間割・日常品の表示
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...registerMain,
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        //追加の持ち物を入力するText表示（上段）
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int j = 0; j < 3; j++)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: SizedBox(
                  width: 200,
                  //参照#94 void textFeildFocusController(int i)
                  child: TextField(
                    controller: itemTextControllers[j],
                    onChanged: (value) {
                      additionalItems[j] = value;
                    },
                    focusNode: focusNods[j],
                    decoration: InputDecoration(
                      label: Text("追加${j + 1}"),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        //追加の持ち物を入力するText表示（下段）
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int j = 3; j < 6; j++)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: itemTextControllers[j],
                    onChanged: (value) {
                      additionalItems[j] = value;
                    },
                    focusNode: focusNods[j],
                    decoration: InputDecoration(
                      label: Text("追加${j + 1}"),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        //保存・キャンセルのボタン表示
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                onPressed: () {
                  //保存前にアラート表示
                  showDialog(
                      context: context, builder: (_) => const RegisterDialog());
                },
                child: Text(
                  updateButtonText,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                onPressed: () {
                  debugPrint('#338:cancel');
                  ref.read(indexNotifierProvider.notifier).updateState(0);
                },
                child: const Text(
                  'キャンセル',
                  style: TextStyle(fontSize: 30),
                ), //  '登録',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//保存前にアラート表示させるWidget
class RegisterDialog extends ConsumerWidget {
  const RegisterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayBelongings dayData = ref.watch(dayBelongingsNotifierProvider);

    //データベースへ情報を更新
    void submitNewData() async {
      if (dayData.isHistoryData) {
        //変更保存のpatch
        final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
            'api/v1/teacher/timetables-history/${dayData.selectedDate}');
        try {
          final response = await http.patch(url,
              headers: {"Content-type": "application/json"},
              body: json.encode(dayData));
          final resStatus = response.statusCode;
          final decodedRes = await json.decode(response.body);
          debugPrint("patch結果: $resStatus,${decodedRes['message']}");
        } catch (error) {
          debugPrint(error.toString());
          throw Exception('Failed to load data: $error');
        }
      } else {
        //変更保存のpost
        final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
            'api/v1/teacher/timetables-history/${dayData.selectedDate}');

        try {
          final response = await http.post(url,
              headers: {"Content-type": "application/json"},
              body: json.encode(dayData));
          final resStatus = response.statusCode;
          final decodedRes = await json.decode(response.body);
          debugPrint("post結果: $resStatus,${decodedRes['message']}");
        } catch (error) {
          debugPrint(error.toString());
          throw Exception('Failed to load data: $error');
        }
      }
    }

    return CupertinoAlertDialog(
      title: const Text("確認"),
      content: const Text('生徒へ送信してもいいですか？'),
      actions: [
        TextButton(
          onPressed: () {
            debugPrint("送信します");
            submitNewData();
            Navigator.pop(context);
            _showSentDialog(context);
          },
          child: const Text('送信'),
        ),
        TextButton(
            onPressed: () {
              debugPrint('キャンセルします');
              //❗️❗️画面変更の編集中❗️❗️
              ref.read(indexNotifierProvider.notifier).updateState(1);
              Navigator.pop(context);
            },
            child: const Text('キャンセル'))
      ],
    );
  }
}

// 送信しましたダイアログを表示
void _showSentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("送信しました"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
