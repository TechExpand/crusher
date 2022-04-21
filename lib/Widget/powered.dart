import 'package:flutter/material.dart';


Widget poweredBy(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('POWERED BY EDO NEWMAP', style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width: 4,),
        Container(
            height: 20,
            width: 20,
            child: Image.asset('assets/images/edo.png', fit: BoxFit.cover,)),
      ],
    ),
  );
}