import 'package:flutter/material.dart';
import "../models/chapter.dart";
import '../widgets/chapter_card.dart';
import '../theme/app_colors.dart';
import '../services/loadjson.dart';


class ChapterScreen extends StatelessWidget{

  final String subjectName;
  final String path;

  const ChapterScreen({
    super.key,
    required this.subjectName,
    required this.path
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(subjectName,
        style: TextStyle(
          color: AppColors.textForInsidePrimaryColoLikeAppBarr
        ),
        ),
      ),
      body: FutureBuilder<List<Chapter>>(
        future: Loadjson.loadJson(path),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError){
            return Center(
              child: Text("Error loading chapters"),
            );
          }
          if (snapshot.hasData){
            List<Chapter> chapters = snapshot.data!;
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return ChapterCard(chapter: chapters[index]);
              },
            );
          } 
          return Center(
            child: Text("No chapters found"),
          );
        }
      )
    );
  }
}