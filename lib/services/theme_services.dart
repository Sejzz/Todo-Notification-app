 import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class theme_services{
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  //like a json file
//? if there is a value
//?? if there is any value so obv return true otherwise the given thing.
// if there is minus or -ve value  it will return false.
  bool _LoadThemeFromBox()=>_box.read(_key)??false;
  ThemeMode get  theme => _LoadThemeFromBox()?ThemeMode.dark:ThemeMode.light;
  void switchTheme(){
Get.changeThemeMode(_LoadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
_saveThemeToBox(!_LoadThemeFromBox());
  }
 }