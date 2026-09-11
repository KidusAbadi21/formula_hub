import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/formula.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../services/mixed_text_refiner.dart';

class FormulaDetailScreen extends StatelessWidget{

  final Formula formula;

  const FormulaDetailScreen({
    super.key,
    required this.formula,

  });
 
 @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(formula.name)    
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
            decoration: BoxDecoration(
              color: AppColors.formulaDetail,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Math.tex(
                formula.expression,
                textStyle: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20,),
                child: Text(
                  'Where:',
                  // padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15
              ),
              ...formula.variables.entries.map((entry) => 
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Math.tex(
                        entry.key,
                        // style: TextStyle(
                          // fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        // ),
                      ),
                      SizedBox(width: 25),
                      MixedText(
                        text: entry.value,
                        //style: TextStyle(
                          // fontSize: 16,
                        // ),
                      ),
                    ],
                  ),
                ),
              ).toList()
            ],
          ),
          SizedBox(height: 20),
         if (formula.specialCases.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'Special Cases:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: MixedText(
                text: formula.specialCases.join(', '),
              ),
            ),
          ],
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Si unit: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    formula.siUnit,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ),
            ],
          ),
        ],
      )
    );
  }
}