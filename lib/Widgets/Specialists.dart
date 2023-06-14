import 'package:flutter/material.dart';
import 'package:healing/Widgets/CardSpecialist.dart';
import 'package:healing/Widgets/TextBase.dart';

class Specialists extends StatelessWidget {

  List specialist = [
    {
      'name': 'Luis Humberto Hernández Lavacude',
      'imagen': Icons.family_restroom
    },
    {
      'name': 'Yammis Castañeda',
      'imagen': Icons.medical_information_rounded
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: TextBase('Especialistas', align: TextAlign.start, weight: FontWeight.bold,),
          ),
          SizedBox(
            height: 115,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialist.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> speciality = specialist[index];
                return CardSpecialist(speciality['name'], speciality['imagen']);
              }
            ),
          )
        ],
      ),
    );
  }

}