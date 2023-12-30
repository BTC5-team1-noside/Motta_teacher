import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher/models/belongings.dart';
import 'package:teacher/widgets/belongings_data.dart';
import 'package:intl/intl.dart';
import "package:teacher/models/date.dart";
import "package:teacher/widgets/belongings.dart";
import 'package:teacher/widgets/subject_dropdown.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class PageCheckList extends ConsumerWidget {
  const PageCheckList({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(dateNotifierProvider);
    final DayBelongings dayData = ref.watch(dayBelongingsNotifierProvider);

    late List<Widget> registerMain;
    late Widget timetable;
    late Widget belongings;
    late String updateButtonText;

    dayData.isHistoryData
        ? updateButtonText = '変更保存'
        : updateButtonText = '新規登録';

    final List<TextEditingController> itemTextControllers = [];
    for (int i = 0; i < 6; i++) {
      itemTextControllers.add(TextEditingController());
    }

    for (int i = 0; i < dayData.additionalItemNames.length; i++) {
      // debugPrint("page_check_list #51 ; ${dayData.additionalItemNames[i]}");
      itemTextControllers[i].text = dayData.additionalItemNames[i];
    }

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
      final List<String> additionalItems = [];

      for (int k = 0; k < 6; k++) {
        if (itemTextControllers[k].text.trim().isEmpty) continue;
        additionalItems.add(itemTextControllers[k].text);
      }

      DayBelongings newSet =
          dayData.copyWith(additionalItemNames: additionalItems);
      debugPrint("page_check_list_#76 original:$dayData");
      debugPrint("page_check_list_#77 newSet: $newSet");
      final notifier = ref.read(dayBelongingsNotifierProvider.notifier);
      notifier.updateState(newSet);

      //POSTメソッドを追記（gon_versionからの追記）
      if (dayData.isHistoryData) {
        debugPrint("変更を更新しました。");

        //❗️開発環境と本番環境が切り替えできるようになったら、コメントアウトを外す
        // final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
        //     'api/v1/teacher/timetables-history/${dayData.selectedDate}');

        // try {
        //   final response = await http.patch(url,
        //       headers: {"Content-type": "application/json"},
        //       body: json.encode(newSet));
        //   final resStatus = response.statusCode;
        //   // final decodedRes = await json.decode(response.body);
        //   debugPrint("page_check_list #89 : $resStatus");
        //   // debugPrint("page_check_list #89 : $decodedRes");
        // } catch (error) {
        //   debugPrint(error.toString());
        //   throw Exception('Failed to load data: $error');
        // }
        //❗️開発環境と本番環境が切り替えできるようになったら、コメントアウトを外す
      } else {
        debugPrint("新規登録しました。");

        //❗️開発環境と本番環境が切り替えできるようになったら、コメントアウトを外す
        // final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
        //     'api/v1/teacher/timetables-history/${dayData.selectedDate}');

        // try {
        //   final response = await http.post(url,
        //       headers: {"Content-type": "application/json"},
        //       body: json.encode(newSet));
        //   final resStatus = response.statusCode;
        //   // final decodedRes = await json.decode(response.body);
        //   debugPrint("page_check_list #89 : $resStatus");
        //   // debugPrint("page_check_list #89 : $decodedRes");
        // } catch (error) {
        //   debugPrint(error.toString());
        //   throw Exception('Failed to load data: $error');
        // }
        //❗️開発環境と本番環境が切り替えできるようになったら、コメントアウトを外す
      }
    }

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
                onPressed: () async {
                  const flavor = String.fromEnvironment('flavor');
                  debugPrint('日にちを減らす');

                  if (flavor == 'dev') {
                    debugPrint('dev環境の値を取得');
                  }
                  debugPrint(dayData.selectedDate);
                  final timeF = DateTime.parse(dayData.selectedDate)
                      .add(const Duration(days: -1));
                  final f = DateFormat('yyyy-MM-dd');
                  final beforeDay = f.format(timeF);
                  debugPrint(beforeDay);
                  final DayBelongings data =
                      await getBelongingsApiData(date: beforeDay);
                  ref
                      .read(dayBelongingsNotifierProvider.notifier)
                      .updateState(data);
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
                onPressed: () async {
                  debugPrint('日にちを増やす');
                  final timeF = DateTime.parse(dayData.selectedDate)
                      .add(const Duration(days: 1));
                  debugPrint('日月火水木金土'[timeF.weekday - 1]);
                  final f = DateFormat('yyyy-MM-dd');
                  final afterDay = f.format(timeF);
                  ref.read(dateNotifierProvider.notifier).updateState(afterDay);
                  final DayBelongings data =
                      await getBelongingsApiData(date: afterDay);
                  ref
                      .read(dayBelongingsNotifierProvider.notifier)
                      .updateState(data);
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
