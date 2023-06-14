import 'package:flutter/material.dart';
import 'package:healing/Widgets/CardSpecialty.dart';
import 'package:healing/Widgets/TextBase.dart';

class Specialties extends StatelessWidget {

  List specialities = [
    {
      'name': 'Familiar',
      'icon': Icons.family_restroom
    },
    {
      'name': 'General',
      'icon': Icons.medical_information_rounded
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: TextBase('Especialidades', align: TextAlign.start, weight: FontWeight.bold,),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialities.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> speciality = specialities[index];
                return CardSpeciality(speciality['name'], speciality['icon']);
              }
            ),
          )
        ],
      ),
    );
  }

}