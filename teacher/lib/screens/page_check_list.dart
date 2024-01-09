import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import 'package:teacher/widgets/belongings_data.dart';
import 'package:intl/intl.dart';
import "package:teacher/models/date.dart";
// import "package:teacher/widgets/belongings.dart";
import 'package:teacher/widgets/belonging_refactaring.dart';
import 'package:teacher/widgets/subject_dropdown.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class PageCheckList extends ConsumerWidget {
  // const PageCheckList({super.key});
  PageCheckList({super.key});
  List<Widget> generateTimeTable(DayBelongings pathData) {
    List<Widget> rows = [];
    for (int i = 0; i < pathData.subjects.length; i++) {
      final row = Row(
        children: [
          Text(
            "${i + 1}時間目: ",
            style: const TextStyle(color: Colors.black, fontSize: 32),
          ),
          //
          SizedBox(width: 160, child: SubjectDropdown(i)),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

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
      additionalItems = List.filled(6, "");
    }
    return additionalItems;
  }

  final List<FocusNode> focusNods = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("page_check_list:START");
    ref.watch(dateNotifierProvider);
    final DayBelongings dayData = ref.watch(dayBelongingsNotifierProvider);
    var additionalItems = generateAdditionalItems(dayData);
    // final itemTextControllers = generateItemTextControllers();
    late List<Widget> registerMain;
    late Widget timetable;
    late Widget belongings;
    late String updateButtonText;

    // final List<FocusNode> focusNods = [];
    final List<TextEditingController> itemTextControllers = [];

    for (int i = 0; i < 6; i++) {
      focusNods.add(FocusNode());
    }

    void textFeildFocusController(int i) {
      // FocusNodeにリスナーを追加して、フォーカスが変更されたときに呼び出す処理を設定

      //❗️❗️追加アイテムが編集途中で消える原因はここ?。
      focusNods[i].addListener(() {
        if (!focusNods[i].hasFocus) {
          // フォーカスが離れたときの処理
          debugPrint('Focus lost $i');
          DayBelongings newSet =
              dayData.copyWith(additionalItemNames: additionalItems);
          final notifier = ref.read(dayBelongingsNotifierProvider.notifier);
          notifier.updateState(newSet);
          debugPrint('#79 newSet; $newSet');
          debugPrint('#80 dayData; $dayData');
        }
      });
    }

    debugPrint("screen_page_check_list #46;${additionalItems.length}");
    debugPrint("screen_page_check_list #46;${additionalItems.toList()}");
    dayData.isHistoryData
        ? updateButtonText = '変更保存'
        : updateButtonText = '新規登録';

    //TextFieldの初期設定:start
    for (int i = 0; i < 6; i++) {
      itemTextControllers.add(TextEditingController());
      textFeildFocusController(i);
    }

    //❗️❗️追加アイテムが編集途中で消える原因はここ?。
    //❗️i < dayData.additionalItemNames.length =>6に固定
    for (int i = 0; i < dayData.additionalItemNames.length; i++) {
      debugPrint('#71 ; ${dayData.additionalItemNames[i]}');
      itemTextControllers[i].text = dayData.additionalItemNames[i];
    }
    //TextFieldの初期設定:end
    debugPrint('#104 ; ${dayData.additionalItemNames}');
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

    final timeF = DateTime.parse(dayData.selectedDate);
    final day = '日月火水木金土日'[timeF.weekday];

    void submitNewData() async {
      debugPrint("page_check_list_#76 登録データ:$dayData");

      if (dayData.isHistoryData) {
        debugPrint("変更を更新しました。");

        final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
            'api/v1/teacher/timetables-history/${dayData.selectedDate}');
        try {
          final response = await http.patch(url,
              headers: {"Content-type": "application/json"},
              body: json.encode(dayData));
          final resStatus = response.statusCode;
          final decodedRes = await json.decode(response.body);
          debugPrint(
              "page_check_list #89 : $resStatus,${decodedRes['message']}");
        } catch (error) {
          debugPrint(error.toString());
          throw Exception('Failed to load data: $error');
        }
      } else {
        final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
            'api/v1/teacher/timetables-history/${dayData.selectedDate}');

        try {
          final response = await http.post(url,
              headers: {"Content-type": "application/json"},
              body: json.encode(dayData));
          final resStatus = response.statusCode;
          final decodedRes = await json.decode(response.body);
          debugPrint(
              "page_check_list #89 : $resStatus,${decodedRes['message']}");
        } catch (error) {
          debugPrint(error.toString());
          throw Exception('Failed to load data: $error');
        }
      }
    }

    void toChangeDate(DayBelongings dayData, int value) async {
      final time =
          DateTime.parse(dayData.selectedDate).add(Duration(days: value));
      final changingDate = DateFormat('yyyy-MM-dd').format(time);
      final DayBelongings data = await getBelongingsApiData(date: changingDate);
      if (data.isHistoryData) {
        additionalItems = [
          ...data.additionalItemNames,
        ];
      } else {
        additionalItems = List.filled(6, ""); //
      }
      ref.read(dayBelongingsNotifierProvider.notifier).updateState(data);
    }

    debugPrint('#178 ; ${dayData.additionalItemNames}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...registerMain,
          ],
        ),
        const SizedBox(
          height: 50,
        ),
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
        SizedBox(
          height: 100,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            onPressed: submitNewData,
            child: Text(
              updateButtonText,
              style: const TextStyle(fontSize: 30),
            ), //  '登録',
          ),
        ),
      ],
    );
  }
}
