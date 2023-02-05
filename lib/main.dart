import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/services/notifications.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui_pages/home.dart';
import 'package:todo_app/ui_pages/login.dart';
import 'package:todo_app/ui_pages/splash.dart';
import 'package:todo_app/ui_pages/theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
   tz.initializeTimeZones();
  // initializeNotification();
 // Notify().displayNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: theme_services().theme,
     
      home: splash(username: '')
      // login(username: '', password: '',),
    );
  }
}



 