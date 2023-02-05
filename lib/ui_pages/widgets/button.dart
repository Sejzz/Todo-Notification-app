import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:todo_app/ui_pages/theme.dart';


class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(  
        padding: EdgeInsets.only(left: 24, right: 15, top: 19),
        width: 120,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple
          
        ),
        child:  
        Text(label,
        style: TextStyle(color: Colors.white),),
      ),
    );
  }
}