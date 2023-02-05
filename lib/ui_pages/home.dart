import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notifications.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/ui_pages/add_task.dart';
import 'package:todo_app/ui_pages/login.dart';
import 'package:todo_app/ui_pages/theme.dart';
import 'package:todo_app/ui_pages/widgets/button.dart';
import 'package:todo_app/ui_pages/widgets/task_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selecteddate = DateTime.now();
  final _taskController = Get.put(TaskController());
  NotificationsServices notificationsServices = NotificationsServices();
  //  var notifyHelper;
@override
void initState(){
  super.initState();
 // notifyHelper = Notify();
   notificationsServices.initializeNotification();
     tz.initializeTimeZones();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
        _addTaskBar(),
        _addDateBar(),
        SizedBox(height: 10,),
        _showTasks(),
       
        ],
      ),
    );
  }


  _showTasks(){
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index){
           // print(_taskController.taskList.length);
            Task task = _taskController.taskList[index];  //instance of task.dart
            print(task.toJson());
           if(task.repeat=='Daily' ){
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              notificationsServices.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task
              );
             // print(myTime);
         //  });
            return AnimationConfiguration.staggeredList(
              position: index, 
              child: SlideAnimation(  
                child: FadeInAnimation(
                  child: Row(  
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(task),
                      )
                    ],
                  ) 
                   ),

              )
              );
            
          }
          if(task.date == DateFormat.yMd().format(selecteddate)){
 return AnimationConfiguration.staggeredList(
              position: index, 
              child: SlideAnimation(  
                child: FadeInAnimation(
                  child: Row(  
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(task),
                      )
                    ],
                  ) 
                   ),

              )
              );
            
          }

          else{
           return Container();
          }
       } );
      },)
      );
  }

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1?
        MediaQuery.of(context).size.height*0.24:
        MediaQuery.of(context).size.height*0.32,
        color: Get.isDarkMode? Colors.grey[900]: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[400]
              ),
            ),
            Spacer(),
            task.isCompleted == 1?Container(

            ): _bottomSheetButton(label: "Task Completed", 
            onTap: (){
              _taskController.markTaskCompleted(task.id!);
              Get.back();
            }, color: Colors.deepPurple,
            context: context
            ),
           
             _bottomSheetButton(label: "Delete Task", onTap: (){
              _taskController.delete(task);
            //  _taskController.getTasks();
              Get.back();
            }, color: Colors.red[300]!,
            context: context
            ),
             SizedBox(height: 20,),
             _bottomSheetButton(label: "Close", onTap: (){
              Get.back();
            }, color: Colors.red[300]!,
            isClose: true,
            context: context
            ),
            SizedBox(height: 10,)
          ],
        ),
      )
    );

  }

  _bottomSheetButton(
    {
      required String label,
      required Function()? onTap,
      required Color color,
      bool isClose = false,
      required BuildContext context,
    }
  ){
  return GestureDetector(
    onTap: onTap,
    child:  Container(  
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width*0.9,
     // color: isClose == true? Colors.red:color,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose==true?Get.isDarkMode?Colors.grey[600]!: Colors.grey[300]!:color
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClose == true? Colors.transparent:color,
      ),
      child: Center(child: Text(label,
      style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
      )),
    ),
  );
  }

 _addDateBar(){
  return  Container(
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: DatePicker(  
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.deepPurple,
            selectedTextColor: Colors.white,
            dateTextStyle: GoogleFonts.lato(
           textStyle: TextStyle(  
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            ),
            ),
             dayTextStyle: GoogleFonts.lato(
           textStyle: TextStyle(  
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            ),
            ),
             monthTextStyle: GoogleFonts.lato(
           textStyle: TextStyle(  
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey
            ),
            ),
            onDateChange: (date){
             setState(() {
                selecteddate = date;
             });
            },
          ),
        );
 }
_addTaskBar(){
  return   Container(
           margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
              
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text(DateFormat.yMMMd().format(DateTime.now()),
                   style: subHeading,
                   ),
                   Text("Today", 
                   style: heading,),
                  ],
                ),
              ),
              MyButton(label: "+ Add Task", onTap: () async{
                await Get.to(() => addTask());
                _taskController.getTasks();
              }
              //=> Get.to(addTask())
              ),
            ],
           ),
         );
}
  myappbar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(  
        onTap: () {
          print('tapped');
          theme_services().switchTheme();
        
          NotificationsServices().displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
            );

          //  NotificationsServices().scheduledNotification();


        },
        child: Icon(Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
        size: 20,
        //coming from our getx package
        color: Get.isDarkMode ? Colors.white:Colors.black,
        ),
      ),
      actions: [
       IconButton(
        icon: const Icon(Icons.logout_rounded),
         color: Colors.grey,
         iconSize: 28,
        onPressed: () async{
                 final SharedPreferences sharedPreferences = 
                    await SharedPreferences.getInstance();
                    sharedPreferences.remove('username');
                     Navigator.push(context,  MaterialPageRoute(
      builder: (context) =>  login(username: '', password: '',)
      )
      );

          },
    ),
        
      
        SizedBox(width: 20,)
      ],
    );
  }
}