import 'package:ciclojobs/src/pages/home_page.dart';
import 'package:ciclojobs/src/pages/login_page.dart';
import 'package:ciclojobs/src/pages/register_page.dart';
import 'package:ciclojobs/src/pages/welcome_page.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> GetApplicationRoute(){
  return <String,WidgetBuilder>{
    '/':(BuildContext context) =>  const WellcomePage(),
    'login':(BuildContext context) =>  const LoginPage(),
    'register':(BuildContext context) => const RegisterPage(),
    'home':(BuildContext context) =>  const HomePage()
  
  };
}