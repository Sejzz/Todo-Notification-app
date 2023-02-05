import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui_pages/home.dart';
import 'package:get/get.dart';

class login extends StatefulWidget {
  String username;
  String password;
  login({super.key,
  required this.username,
  required this.password,
  });

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
    final _formKey = GlobalKey<FormState>();
   TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();

    late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
          
            Color.fromARGB(255, 103, 58, 183),
            Color.fromARGB(255, 149, 117, 205)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(children: [
                Image.asset(
                  "assets/images/todo-01.png",
                  height: 250,
                  width: 300,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _password,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.white)),
                        labelText: 'Create a Username',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.white)),
                         validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be empty";
                          }
          
                          return null;
                        },
                  ),
                
                ),
                SizedBox(
                  height: 22,
                ),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _username,
                     obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password_rounded,
                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.white)),
                        labelText: 'Enter Password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be empty";
                          }
          
                          return null;
                        },
                       
                  ),
                
                ),
                SizedBox(height: 50,),
                Container(
                  width: 200,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState == null) {
              print("_formKey.currentState is null!");
            } else if (_formKey.currentState!.validate()) {
              print("Form input is valid");
            
                        print("Data added");
                        _username.clear();
                        _password.clear();
                      
                      final SharedPreferences sharedPreferences = 
                      await SharedPreferences.getInstance();
                      sharedPreferences.setString('username', _username.text);
                      
                      Navigator.push(context,  MaterialPageRoute(
                builder: (context) =>  Home()
               // username()
                         )   );
            }
                     // Get.to(home());
                    //  print(_username.text);
          
                      //storedata();
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Color.fromARGB(255, 103, 58, 183),
                        fontSize: 20,
                        // fontWeight: FontWeight.normal
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey;
                        }
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                    ),
                    //style: ButtonStyle(backgroundColor: ,
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}