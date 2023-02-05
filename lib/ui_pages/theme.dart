import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color lightcolor = Color.fromARGB(0, 243, 204, 255);
const Color mediumcolor = Color.fromARGB(0, 208, 156, 250);
const Color darkcolor = Color.fromARGB(0, 165, 85, 236);
const Color white = Colors.white;
const primarycolor = mediumcolor;
const Color darkGrey = Color(0x121212);
const Color darkHeadercolor = Color(0x424242);


class Themes{

  static final light = ThemeData(
    backgroundColor: Colors.white,
        primaryColor: primarycolor,
        brightness: Brightness.light,
      );
     static final dark =  ThemeData(
      backgroundColor: darkGrey,
        primaryColor: darkGrey,
        brightness: Brightness.dark,
      );
}

TextStyle get subHeading{  //getting something means returning something
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey[400]:Colors.grey
    )
  );
}

TextStyle get heading{  //getting something means returning something
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
    )
  );
}
TextStyle get titleStyle{  //getting something means returning something
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.white:Colors.black
    )
  );
}
TextStyle get subtitleStyle{  //getting something means returning something
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600]
    )
  );
}