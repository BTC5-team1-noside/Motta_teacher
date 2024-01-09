import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:teacher/models/belongings.dart';

// void getApiData() async {
Future<DayBelongings> getBelongingsApiData({String date = "2023-12-25"}) async {
  // const baseUrl = String.fromEnvironment('base_url');
  // debugPrint('belongings_dart #10 base_url ;$baseUrl');
  final url = Uri.https(
      'motta-9dbb2df4f6d7.herokuapp.com', 'api/v1/teacher/subjects/$date');
  // 'motta-9dbb2df4f6d7.herokuapp.com', 'api/v1/teacher/subjects/$date');
  // 'motta-9dbb2df4f6d7.herokuapp.com', '$endpoint/$date');

  //server.jsからデータベースをローカルで準備して、開発環境で設定しようとしたけど上手くいかず。localhostの
  // final url = Uri.http('localhost:8000/api/v1/teacher/subjects/$date');
  // debugPrint('belongings_dart #14 url ;$url');

  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    final dataFromJson = DayBelongings.fromJson(data);
    return dataFromJson;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}

Future<DayBelongings> getBelongingsApiData2(String calendarDate) async {
  // const date = '2023-12-25';
  final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
      'api/v1/teacher/subjects/$calendarDate');
  // 'motta-9dbb2df4f6d7.herokuapp.com', '$endpoint/$date');
  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    final dataFromJson = DayBelongings.fromJson(data);
    return dataFromJson;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}
