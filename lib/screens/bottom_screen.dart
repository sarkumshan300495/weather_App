import 'package:flutter/material.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({required this.icon,required this.text,required this.degree, super.key});
final IconData icon;
final String text;
final String degree;
  @override
  Widget build(BuildContext context) {
    return 
              Container(
                padding: EdgeInsets.all(2),
                height: 100,
                width: 100,
              
                decoration: BoxDecoration(
                    color: Colors.black12,
                  border: Border.all(width: 1,color: Colors.white10,style: BorderStyle.solid)),
                child: Column(
                  children: [
                   Icon(icon),
                   const SizedBox(height: 5,),
                   textshortcut(textname: text, fontsize: 15, fontweight: FontWeight.normal),
                   const SizedBox(height: 5,),
                             textshortcut(textname: degree, fontsize: 19, fontweight: FontWeight.normal),
                  ],
                ),
              );
  }
   Widget textshortcut(
      {required String textname,
      required double fontsize,
      required FontWeight fontweight}) {
    return Text(
      textname,
      style: TextStyle(
          fontSize: fontsize, fontWeight: fontweight, color: Colors.white),
    );
  }
}