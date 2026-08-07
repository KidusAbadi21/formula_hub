import 'package:flutter/material.dart';
import "../models/chapter.dart";
import '../widgets/chapter_card.dart';
import '../theme/app_colors.dart';


class ChapterScreen extends StatelessWidget{

  final String subjectName;
  final List<Chapter> chapters;

  const ChapterScreen({
    super.key,
    required this.subjectName,
    required this.chapters
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
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ChapterCard(chapter: chapters[index]);
        },
      )
    );
  }
}