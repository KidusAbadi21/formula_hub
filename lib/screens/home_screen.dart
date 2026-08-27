import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/subject_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Formula_Hub",
          style: TextStyle(
            color: AppColors.textForInsidePrimaryColoLikeAppBarr
          ),
        ),
      ), 
      body: Column(
        children: [
          Container(
            // color: const Color.fromARGB(255, 235, 236, 236),
            // height: 850.0,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 110.0,
              left: 20.0
            ),
            child: Text(
              "Hello! 👋",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
           Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 60, bottom: 20),
            // color: const Color.fromARGB(255, 223, 222, 222),
            child: Text("Welcome to Formula_Hub, please choose a subject to proceed..."),
          ),
          SubjectCard(
            title: "Physics",
            imagepath: "assets/images/image-removebg-preview (5).png",
            path: "assets/data/physics.json"),
          SubjectCard(
            title: "Mathematics",
            imagepath: "assets/images/5494710.png",
            path: "assets/data/maths.json"),
          SubjectCard(
            title: "Chemistry",
            imagepath: "assets/images/201607.png",
            path: "assets/data/chemistry.json"),
        ],
      ), 
    ),
  );
  }
}