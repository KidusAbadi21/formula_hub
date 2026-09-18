import "../models/formula.dart";
import "../models/bookmarked_formula.dart";

import "../services/bookmark_service.dart";

import 'package:flutter/services.dart';
import 'dart:convert';

class Loadjson {

  static Future<List<Formula>> loadJson(
    String path,
    int chapterIndex,
  ) async {

    var jsonString =
        await rootBundle.loadString(path);

    Map<String, dynamic> dartMap =
        jsonDecode(jsonString);

    List<dynamic> formulas =
        dartMap["chapters"][chapterIndex]["formulas"];

    return formulas.map(
      (formula) => Formula(
        name: formula['name'],
        expression: formula['expression'],

        variables: Map<String, String>.from(
          formula['Variables'] ?? {},
        ),

        specialCases: List<String>.from(
          formula['specialcases'] ?? [],
        ),

        siUnit: formula['siunit'] ?? '',
      ),
    ).toList();
  }

  static Future<List<BookmarkedFormula>>
      loadBookmarkedFormulas() async {

    List<String> paths = [
      'assets/data/physics.json',
      'assets/data/maths.json',
      'assets/data/chemistry.json',
    ];

    List<String> subjects = [
      'Physics',
      'Mathematics',
      'Chemistry',
    ];


    List<String> bookmarkedIds =
        await BookmarkService.getBookmarks();

    List<BookmarkedFormula> result = [];



    for (int subjectIndex = 0;
        subjectIndex < paths.length;
        subjectIndex++) {

      String jsonString =
          await rootBundle.loadString(
        paths[subjectIndex],
      );

      Map<String, dynamic> dartMap =
          jsonDecode(jsonString);

      List<dynamic> chapters =
          dartMap["chapters"];


      for (var chapter in chapters) {

        int chapterNumber =
            chapter["number"];

        String chapterName =
            chapter["title"];

        List<dynamic> formulas =
            chapter["formulas"];


        for (var formula in formulas) {

          String formulaName =
              formula["name"];


          String formulaId =
              BookmarkService.createId(
            subject: subjects[subjectIndex],
            chapterNumber: chapterNumber,
            formulaName: formulaName,
          );


          if (bookmarkedIds.contains(formulaId)) {

            Formula formulaObject =
                Formula(
              name: formula['name'],

              expression:
                  formula['expression'],

              variables:
                  Map<String, String>.from(
                formula['Variables'] ?? {},
              ),

              specialCases:
                  List<String>.from(
                formula['specialcases'] ?? [],
              ),

              siUnit:
                  formula['siunit'] ?? '',
            );


            result.add(
              BookmarkedFormula(
                subject:
                    subjects[subjectIndex],

                chapterNumber:
                    chapterNumber,

                chapterName:
                    chapterName,

                formula:
                    formulaObject,
              ),
            );
          }
        }
      }
    }

    return result;
  }
}

