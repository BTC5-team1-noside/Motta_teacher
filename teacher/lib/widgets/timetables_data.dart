import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:teacher/models/timetables.dart';

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
