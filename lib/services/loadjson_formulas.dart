import "../models/formula.dart";
import 'package:flutter/services.dart';
import 'dart:convert';
class Loadjson {
  static Future<List<Formula>> loadJson(String path, int chapterIndex) async {
    var jsonString = await rootBundle.loadString(path);

    Map<String, dynamic> dartMap = jsonDecode(jsonString);

    List<dynamic> formulas = dartMap["chapters"][chapterIndex]["formulas"];

    return formulas.map(
      (formula) => Formula(
        name: formula['name'],
        expression: formula['expression'],
        variables: Map<String, String>.from(formula['Variables']),
        specialCases: List<String>.from(formula['specialcases'] ?? []),
        siUnit: formula['siunit'] ?? '',
      )
    ).toList();
  }
}


