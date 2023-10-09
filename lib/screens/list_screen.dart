import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({ required this.time,required this.icon,required this.frenhit, super.key});

  final String frenhit;
  final String time;
  final IconData icon;
  

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 20,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 100,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.black12,
            borderRadius: BorderRadius.horizontal(
              
                left: Radius.elliptical(10, 10),
                right: Radius.elliptical(10, 10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            textshortcut(
                textname: time,
                fontsize: 12,
                fontweight: FontWeight.w600),
            const SizedBox(height: 10,),
             Icon(
              icon,
              size: 25,
            ),
            const SizedBox(height: 10,),
            textshortcut(
                textname: frenhit,
                fontsize: 18,
                fontweight: FontWeight.w500),
          ],
        ),
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