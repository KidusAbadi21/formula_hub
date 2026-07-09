import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String imagepath;

  const SubjectCard({
    super.key, 
    required this.title, 
    required this.imagepath
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          boxShadow: [BoxShadow(
            color:AppColors.shadow,
            offset: Offset(-3, 3),
            blurRadius: 6,
            spreadRadius: 4.0
          ),],
          borderRadius: BorderRadius.circular(10)
        ),
        height: 68.0,
        width: 320.0,
        margin: EdgeInsetsDirectional.all(20),
        padding: EdgeInsets.fromLTRB(16, 12, 18, 12),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Image.asset(
              imagepath,
              width: 50,
              height: 40
            ),
            SizedBox(width: 12.0,),
            Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
              width: 100.0,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
              ),
              SizedBox(height: 4),
              Container(
                child: Text("Explore formulas", 
                  style: TextStyle(
                    color: AppColors.subtitle 
                  )
                ),
              )
            ],),
            const Spacer(),  
            Icon(Icons.arrow_forward_ios, size: 18.0,)
          ],       
        ),
      ),
    );  
  }
}