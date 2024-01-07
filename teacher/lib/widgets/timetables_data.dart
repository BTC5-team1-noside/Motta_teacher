import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:teacher/models/timetables.dart';

Future<List<dynamic>> getStudentsApiData() async {
  const baseUrl = String.fromEnvironment('base_url');
  final url = Uri.https(baseUrl, 'api/v1/teacher/settings/students');
  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    // final dataFromJson = Timetables.fromJson(data);
    return data;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}

Future<Timetables> getTimetablesApiData() async {
  final url = Uri.https(
      'motta-9dbb2df4f6d7.herokuapp.com', 'api/v1/teacher/settings/timetables');
  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    final dataFromJson = Timetables.fromJson(data);
    return dataFromJson;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}

//バックエンドからデータを取得が複数の箇所で行っているのでリファクタリングが必要
Future<List<dynamic>> getBelongingsApiData3() async {
  final url = Uri.https('motta-9dbb2df4f6d7.herokuapp.com',
      '/api/v1/teacher/settings/belongings');
  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    // final dataFromJson = Timetables.fromJson(data);
    return data;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}

Future<List<dynamic>> getItemsApiData() async {
  final url = Uri.https(
      'motta-9dbb2df4f6d7.herokuapp.com', '/api/v1/teacher/settings/items');
  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    // final dataFromJson = Timetables.fromJson(data);
    return data;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}

Future<List<dynamic>> getEventsApiData() async {
  final url = Uri.https(
      'motta-9dbb2df4f6d7.herokuapp.com', '/api/v1/teacher/settings/events');
  try {
    //JSON <=== from API(Database)
    final response = await http.get(url);
    //JsonMAP <=== JSON
    final data = json.decode(response.body);
    // final dataFromJson = Timetables.fromJson(data);
    return data;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Failed to load data: $error');
  }
}
