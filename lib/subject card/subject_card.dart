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
      margin: EdgeInsetsDirectional.all(20),
      child: Material(
        borderRadius: BorderRadius.circular(10), 
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.splashColorlor,
          highlightColor: AppColors.card,
          borderRadius: BorderRadius.circular(10), 
          onTap: () {},
          child: Container(
            height: 68.0,
            width: 320.0,
            padding: EdgeInsets.fromLTRB(16, 12, 18, 13),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                    ),
                  )
                  ),
                  SizedBox(height: 2),
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
        ),
      ),
    );  
  }
}