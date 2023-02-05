
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui_pages/home.dart';
import 'package:todo_app/ui_pages/login.dart';


var finalusername;

class splash extends StatefulWidget {
   final String username;
 const splash(  {Key? key,
      required this.username,
       
     })
      : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

   late var  finalusername;
  @override
  void initState(){

    super.initState();
    getValidationData().whenComplete(() async{
       _navigatetousername();
    },);
   
    
  }

  _navigatetousername()async{
    await Future.delayed(Duration(milliseconds: 2500), (){

    });
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => finalusername == null ? login(username: '',password: '',) : Home()
     // username()
      ));
  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = 
     await SharedPreferences.getInstance();
    var obtainedusername =sharedPreferences.getString('username');
    
    setState(() {
      finalusername = obtainedusername;
      // savingUserData(){
                   //   DatabaseService().savingUserData(widget.username).then((value){
                     //   setState(() {
 // username = value;
  
//});
                    //  }
                    //  );
                   // }
     
    });
  //  print(finalusername);
    print(obtainedusername);
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   Color.fromARGB(255, 149, 117, 205),
        body: 
         Center(
           child: 
           Container( padding: EdgeInsets.only(top: 320),
            child: Column(children: [
                Image.asset(
                  "assets/images/todo-01.png",
                  height: 200,
                  width: 300,
               
             )  ]
           )
            ),
         ) );
    
  }
}