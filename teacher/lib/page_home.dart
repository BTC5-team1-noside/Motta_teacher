import 'package:flutter/material.dart';
import 'package:teacher/belongings.dart';
import 'package:teacher/calender.dart';
import "package:http/http.dart" as http;
import "dart:convert";

// class DayBelongings {
//   DayBelongings({
//     required this.selectedDate,
//     required this.timeTablesHistoryDates,
//     required this.studentsHistory,
//   });

//   final String selectedDate;
//   final List<String> timeTablesHistoryDates;
//   final List<StudentHistory> studentsHistory;

//   factory DayBelongings.fromJson(Map<String, dynamic> json) {
//     return DayBelongings(
//       selectedDate: json["selectedDate"] as String,
//       timeTablesHistoryDates: List<String>.from(
//         json["timeTablesHistoryDates"].map((date) => date as String),
//       ),
//       studentsHistory: List<StudentHistory>.from(
//         json["studentsHistory"]
//             .map((student) => StudentHistory.fromJson(student)),
//       ),
//     );
//   }
// }

// class StudentHistory {
//   final int studentId;
//   final String studentName;
//   final bool checkedInventory;

//   StudentHistory({
//     required this.studentId,
//     required this.studentName,
//     required this.checkedInventory,
//   });

//   factory StudentHistory.fromJson(Map<String, dynamic> json) {
//     return StudentHistory(
//       studentId: json["student_id"] as int,
//       studentName: json["student_name"] as String,
//       checkedInventory: json["checkedInventory"] as bool,
//     );
//   }
// }

Future<List<String>> getStudents() async {
  final url = Uri.https("motta-9dbb2df4f6d7.herokuapp.com",
      "/api/v1/teacher/home/history", {"date": "2024-12-21"});

  try {
    final res = await http.get(url);
    final data = await json.decode(res.body);
    debugPrint("うまくいってます！");
    debugPrint("${data["selectedDate"]}");
    // return data["studentsHistory"].map((el) => el["student_name"]);

    final studentNames = List<String>.from(
        data["studentsHistory"].map((el) => el["student_name"]));
    return studentNames;
  } catch (error) {
    debugPrint("エラーです！");
    throw Future.error("エラーが発生しました: $error");
  }
}

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const MyHomePage(),
            FutureBuilder<List<String>>(
              future: getStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // データがまだ取得されていない場合の表示
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // エラーが発生した場合の表示
                  return Text('エラー: ${snapshot.error}');
                } else {
                  // データを表示
                  final data = snapshot.data;
                  return Column(
                    children: data?.map((el) => Text(el)).toList() ?? [],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
