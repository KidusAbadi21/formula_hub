import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import '../subject card/subject_card.dart';

void main(){
  runApp(
    MyWidget()
  );
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

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
            imagepath: "images/image-removebg-preview (5).png"),
          SubjectCard(
            title: "Mathematics",
            imagepath: "images/5494710.png"),
          SubjectCard(
            title: "Chemistry",
           imagepath: "images/201607.png"),
        ],
      ), 
    ),
  );
  }
}
  
  // Container(
  //           padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 60, ),
  //           // color: const Color.fromARGB(255, 223, 222, 222),
  //           child: Text("Welcome to Formula_Hub, please choose a subject to proceed..."),
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: AppColors.card,
  //             boxShadow: [BoxShadow(
  //               color:AppColors.shadow,
  //               offset: Offset(-3, 3),
  //               blurRadius: 6,
  //               spreadRadius: 4.0
  //             ),],
  //             borderRadius: BorderRadius.circular(15)
  //           ),
  //           height: 68.0,
  //           width: 320.0,
  //           margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
  //           padding: EdgeInsets.fromLTRB(25, 11, 0, 11),
  //           alignment: Alignment.centerLeft,
  //           child: Column(
  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [Container(
  //               alignment: Alignment.centerLeft,
  //               child: Text("Mathematics")
  //               ),
  //               SizedBox(height: 6),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Explore formulas", 
  //                   style: TextStyle(
  //                     color: AppColors.subtitle 
  //                   )
  //                 ),
  //             )
  //             ],
  //           )
  //         ),  
  //         Container(
  //           decoration: BoxDecoration(
  //             color: AppColors.card,
  //             boxShadow: [BoxShadow(
  //               color:AppColors.shadow,
  //               offset: Offset(-3, 3),
  //               blurRadius: 6,
  //               spreadRadius: 4.0
  //             ),],
  //             borderRadius: BorderRadius.circular(15)
  //           ),
  //           height: 68.0,
  //           width: 320.0,
  //           margin: EdgeInsetsDirectional.all(20),
  //           padding: EdgeInsets.fromLTRB(25, 11, 0, 11),
  //           alignment: Alignment.centerLeft,
  //           child: Column(
  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [Container(
  //               alignment: Alignment.centerLeft,
  //               child: Text("Physics")
  //               ),
  //               SizedBox(height: 6),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Explore formulas", 
  //                   style: TextStyle(
  //                     color: AppColors.subtitle 
  //                   )
  //                 ),
  //             )
  //             ],
  //           )
  //         ),  
  //         Container(
  //           decoration: BoxDecoration(
  //             color: AppColors.card,
  //             boxShadow: [BoxShadow(
  //               color:AppColors.shadow,
  //               offset: Offset(-3, 3),
  //               blurRadius: 6,
  //               spreadRadius: 4.0
  //             ),],
  //             borderRadius: BorderRadius.circular(15)
  //           ),
  //           height: 68.0,
  //           width: 320.0,
  //           margin: EdgeInsetsDirectional.all(20),
  //           padding: EdgeInsets.fromLTRB(25, 11, 0, 11),
  //           alignment: Alignment.centerLeft,
  //           child: Column(
  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [Container(
  //               alignment: Alignment.centerLeft,
  //               child: Text("Chemistry")
  //               ),
  //               SizedBox(height: 6),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Explore formulas", 
  //                   style: TextStyle(
  //                     color: AppColors.subtitle 
  //                   )
  //                 ),
  //             )
  //             ],
  //           )
  //         ),

