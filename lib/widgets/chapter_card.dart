import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/chapter.dart';

class ChapterCard extends StatelessWidget {
  final Chapter chapter;

  const ChapterCard({
    super.key, 
    required this.chapter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: AppColors.card,
        boxShadow: [BoxShadow(
          color:AppColors.shadow,
          offset: Offset(-3, 3),
          blurRadius: 15,
          spreadRadius: 2.0
      ),],
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Material(
        borderRadius: BorderRadius.circular(10), 
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.splashColorlor,
          borderRadius: BorderRadius.circular(10), 
          onTap: () {
          //   Navigator.push(
          //   context, 
          //   MaterialPageRoute(builder: (context) => Scaffold(appBar: (AppBar(title: Text("HELLO THIS IS A NEW PAGE!!!"))))));
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 68.0,
            ),
            width: 320.0,
            padding: EdgeInsets.fromLTRB(16, 12, 18, 13),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(width: 12.0,),
                Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chapter ${chapter.number}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.5,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(chapter.title, 
                      // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.subtitle 
                        )
                      ),
                  ],),
                ),
                Icon(Icons.arrow_forward_ios, size: 18.0,)
              ],       
            ),
          ),
        ),
      ),
    );  
  }
}