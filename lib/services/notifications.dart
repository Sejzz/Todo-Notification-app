import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui_pages/notified_page.dart';



class NotificationsServices{
   FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      
        //get selectNotificationStream => null;
        
          //Object? get navigationActionId => null; //

  initializeNotification() async {
    configureLocalTimezone();
    //tz.initializeTimeZones();
 final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
         requestSoundPermission: true,
         requestBadgePermission: true,
         requestAlertPermission: true,
         onDidReceiveLocalNotification: onDidReceiveLocalNotification
     );


final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      
        initializationSettings,
        
        //onDidReceiveBackgroundNotificationResponse: selectNotification.,
        );
        // onDidReceiveNotificationResponse:(details) {
           
        // },
          
  //       (NotificationResponse notificationResponse) {
  //     switch (notificationResponse.notificationResponseType) {
  //       case NotificationResponseType.selectedNotification:
  //         selectNotificationStream.add(notificationResponse.payload);
  //         break;
  //       case NotificationResponseType.selectedNotificationAction:
  //         if (notificationResponse.actionId == navigationActionId) {
  //           selectNotificationStream.add(notificationResponse.payload);
  //         }
  //         break;
  //     }
  //   }
  //    // onDidReceiveBackgroundNotificationResponse: ,
  // //       onDidReceiveNotificationResponse:(payload) async {
  // //   if(payload != null){
  // //     print('notification payload: $payload');
  // //   } else{
  // //     print("Notification Done");
  // //   }
  // //   Get.to(()=> Container());
  // // }
  //       //: onSelectNotification
      
      
  //       );
  }
 Future<void> displayNotification({required String title, required String body}) async {
    print("doing test");
    AndroidNotificationDetails androidNotificationDetails = 
    const AndroidNotificationDetails('channelId', 'channelName',
    importance: Importance.max,
    playSound: true,
    priority: Priority.high);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,

    );
    // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    //     'your channel id', 'your channel name',
    //     channelDescription: 'your channel description',
    //     importance: Importance.max, priority: Priority.high);
    // var iOSPlatformChannelSpecifics = new DarwinNotificationDetails();
    // var platformChannelSpecifics = new NotificationDetails(
    //     android: androidPlatformChannelSpecifics,
    //      iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      //'You change your theme',
     // 'You changed your theme back !',
      notificationDetails,
      payload: 'Default_Sound',
      //payload: 'It could be anything you pass',
    );
  
  }

  scheduledNotification(int hour, int minutes, Task task) async {
  //  int newTime = minutes;
     await flutterLocalNotificationsPlugin.zonedSchedule(
         task.id!.toInt(),
         task.title,
         task.note,
         _convertTime(hour, minutes),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name', 
                 channelDescription: 'your channel description')),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime,
             matchDateTimeComponents: DateTimeComponents.time,
             payload: "{$task.title}|" + "{$task.note}|"
             
             );

   }


  tz.TZDateTime  _convertTime(int hour , int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = 
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

 Future<void> configureLocalTimezone() async{
  tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone)); 
    //gets the location n set the location
  }

selectNotification(String? payload) async{
  if(payload != null){
    print('notification payload: $payload');
  }else{
    print("Notification Done");
  }
  Get.to(()=>NotifiedPage(label: payload));
 }


  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
   Get.dialog(Text("welcome to flutter"));
 
  }
}