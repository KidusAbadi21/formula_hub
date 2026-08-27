import "../models/chapter.dart";
import 'package:flutter/services.dart';
import 'dart:convert';
class Loadjson {
  static Future<List<Chapter>> loadJson(String path) async {
    var jsonString = await rootBundle.loadString(path);

    Map<String, dynamic> dartMap = jsonDecode(jsonString);

    List<dynamic> chapters = dartMap["chapters"];

    return chapters.map(
      (chapter) => Chapter(
        title: chapter['title'],
        number: chapter['number']
      )
    ).toList();
  }
}


