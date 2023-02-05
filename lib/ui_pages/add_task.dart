import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notifications.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui_pages/theme.dart';
import 'package:todo_app/ui_pages/widgets/button.dart';
import 'package:todo_app/ui_pages/widgets/input_field.dart';

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {

   final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
   final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 0;
  List<int> remindList = [0,5,10,15,20];
   String _selectedRepeat = "Daily";
  List<String> repeatList = ["None", "Daily",];
  int SelectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: myappbar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView
        (child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Add Task",
            style: heading, ),
          
            myinputField(title: "Title", hint: "Enter your title", controller: _titleController,),
             SizedBox(height: 8,),
            myinputField(title: "Note", hint: "Enter your Note", controller: _noteController,),
            SizedBox(height: 8,),
           myinputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
           widget: IconButton(
            icon: Icon(Icons.calendar_today_outlined,
            color: Colors.grey,
            ),
            onPressed: () {
             _getDateFromUser();
           },),
            ), //dateformat returns a string
             SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: myinputField(
                  title: "Time",
                 hint: _startTime,
                 widget: IconButton(onPressed: () {
                    _getTimeFromUser(isStartTime: true);
                 }
                 , icon: Icon(Icons.access_time_rounded,
                 color: Colors.grey,
                 )),
                 )),
                 SizedBox(width: 0,),
                //   Expanded(child: myinputField(
                //   title: "End Time",
                //  hint: _endTime,
                //  widget: IconButton(onPressed: () {
                //    _getTimeFromUser(isStartTime: false);
                //  }
                //  , icon: Icon(Icons.access_time_rounded,
                //  color: Colors.grey,
                //  )),
                //  ))
              ],
            ),
            // myinputField(title: "Remind", hint: "$_selectedRemind minutes early",
            // widget: DropdownButton(  
            //   icon: Icon(Icons.keyboard_arrow_down,
            //   color: Colors.grey,
              
            //   ),
            //   iconSize: 32,
            //   elevation: 4,
            //   style: subtitleStyle,
            //   underline: Container(height: 0,),
            //   onChanged: ((String? newValue) {
            //     setState(() {
            //       _selectedRemind = int.parse(newValue!);
            //     });
                
            //   }),
            //   items: remindList.map<DropdownMenuItem<String>>((int value){
            //     return DropdownMenuItem<String>(
            //       value: value.toString(),
            //       child: Text(value.toString()
            //       ));
            //   }).toList(),
            // ),
            // ),
            SizedBox(height: 8,),
             myinputField(title: "Repeat", hint: "$_selectedRepeat",
            widget: DropdownButton(  
              icon: Icon(Icons.keyboard_arrow_down,
              color: Colors.grey,
              
              ),
              iconSize: 32,
              elevation: 4,
              style: subtitleStyle,
              underline: Container(height: 0,),
              onChanged: ((String? newValue) {
                setState(() {
                  _selectedRepeat = newValue!;  //here we can direclty pass it, because already in String

                });
                
              }),
              items: repeatList.map<DropdownMenuItem<String>>((String? value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value!, style: TextStyle(color: Colors.grey)
                  ));
              }).toList(),
            ),
            ),
             SizedBox(height: 8,),
        SizedBox(height: 22,),
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Color",
              style: titleStyle,
              ),
              SizedBox(height: 8,),
              Wrap(
                children: List<Widget>.generate(3, 
                (int index) {
                  return GestureDetector(
                    onTap: () {
                        setState(() {
                          SelectedColor = index;
                          print("$index");
                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: 
                        index==0? Colors.deepPurple: 
                        index==1? Colors.deepPurple[300]: 
                        Colors.deepPurple[200],
                    child: SelectedColor==index?Icon(Icons.done,
                    color: Colors.white,
                    size: 16,): Container()
                    
                      ),
                    ),
                  );

                }),
              )
            ],
          ),
          MyButton(label: "Create ToDo", onTap: () => _validateData())
         ],),
         SizedBox(height: 20,)
          ],
        )),
      ),
    );
  }

_validateData(){
  if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
   //add to database
   _addTaskTOdb();
   Get.back();
  }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
    Get.snackbar("Required", "All fields are required!",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.grey[300],
    icon: Icon(Icons.warning_amber_rounded)
    );
  }
}

 _addTaskTOdb() async{
  //here we are passing the data to our model
 int value = await TaskController().addTask(
     task: Task(
   title: _titleController.text,
   note: _noteController.text,
   date: DateFormat.yMd().format(_selectedDate),
  startTime: _startTime,
   endTime: _endTime,
   color: SelectedColor,
  remind: _selectedRemind,
  repeat: _selectedRepeat,
     isCompleted: 0,
  )
  

  );
  print("My id is "+"$value");
 }

  myappbar(BuildContext context){

    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(  
        onTap: () {
       Get.back();

        },
        child: Icon(Icons.arrow_back,
        size: 20,
        //coming from our getx package
        color: Get.isDarkMode ? Colors.white:Colors.black,
        ),
      ),
      actions: [
       Icon(Icons.person,
        size: 20,),
        SizedBox(width: 20,)
      ],
    );
  }


  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(context: context,
     initialDate: DateTime.now(), 
     firstDate: DateTime(2015), 
     lastDate: DateTime(2121)
     );
     if(_pickerDate !=null){
     setState(() {
        _selectedDate = _pickerDate; //when user clicks ok so we want the chosen date to show
        //therefore we will use setstate
     });
     }
     else{
      print("it's null or something is wrong");
     }
  }

 _getTimeFromUser({required bool isStartTime}) async{
  var pickedTime =await  _showTimePicker();
  String _formatedTime = pickedTime.format(context).toString();
//converting to string
  if(pickedTime == null){
    print("Time canceled");
  }else if(isStartTime == true){
   setState(() {
      _startTime = _formatedTime;
   });

  }else if(isStartTime == false){
   setState(() {
      _endTime = _formatedTime;
   });
  }
 }

 _showTimePicker(){
   return showTimePicker(
      context: context, 
  initialTime: TimeOfDay(
    hour: int.parse(_startTime.split(":")[0]), 
  minute: int.parse(_endTime.split(":")[1].split(" ")[0]), 
  )
  );
 }

}