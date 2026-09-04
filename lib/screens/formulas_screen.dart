import 'package:flutter/material.dart';
import "../models/chapter.dart";
import "../models/formula.dart";
import '../widgets/formula_card.dart';
import '../theme/app_colors.dart';
import '../services/loadjson_formulas.dart';


class FormulaScreen extends StatelessWidget{

  final String subjectName;
  final int chapterNumber;
  final String chapterName;
  final int chapterIndex;
  final String path;

  const FormulaScreen({
    super.key,
    required this.subjectName,
    required this.chapterNumber,
    required this.chapterName,
    required this.path,
    required this.chapterIndex,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chapter ${chapterNumber}",
            style: TextStyle(
              color: AppColors.textForInsidePrimaryColoLikeAppBarr,
              fontSize: 20,
            ),
            ),
            Text("${subjectName} • ${chapterName}",
            style: TextStyle(
              color: AppColors.textForInsideofInsidePrimaryColoLikeAppBarr,
              fontSize: 15,
            ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Formula>>(
        future: Loadjson.loadJson(path, chapterIndex),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError){
            return Center(
              child: Text("Error loading formulas ${snapshot.error}"),
            );
          }
          if (snapshot.hasData){
            List<Formula> formulas = snapshot.data!;

            return ListView.builder(
              itemCount: formulas.length,
              itemBuilder: (context, index) {
                return FormulaCard(formula: formulas[index]);
              },
            );
          } 
          return Center(
            child: Text("No formulas found"),
          );
        }
      )
    );
  }
}