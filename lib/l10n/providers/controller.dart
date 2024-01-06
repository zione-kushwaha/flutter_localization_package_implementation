import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class language_controller with ChangeNotifier{
  Locale? _applocal;
  Locale? get Get_app_locale =>_applocal;
  void change_language(Locale type)async{
    _applocal=type;
    SharedPreferences sp= await SharedPreferences.getInstance();
        if(type==Locale('en')){
          await sp.setString('language_code', 'en');
        }else{
          await sp.setString('language_code', 'np');
        }
        notifyListeners();
  }
}