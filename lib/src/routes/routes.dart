import 'package:ciclojobs/src/pages/changepassword_page.dart';
import 'package:ciclojobs/src/pages/edit_page.dart';
import 'package:ciclojobs/src/pages/home_page.dart';
import 'package:ciclojobs/src/pages/login_page.dart';
import 'package:ciclojobs/src/pages/ofertas_detalles_page.dart';
import 'package:ciclojobs/src/pages/register_page.dart';
import 'package:ciclojobs/src/pages/welcome_page.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> getApplicationRoute(){
  return <String,WidgetBuilder>{
    '/':(BuildContext context) =>  const WellcomePage(),
    'changepassword':(BuildContext context) =>  ChangePassword(),
    'login':(BuildContext context) =>  const LoginPage(),
    'register':(BuildContext context) => const RegisterPage(),
    'home':(BuildContext context) =>  const HomePage(),
    'ofertas':(BuildContext context) =>  const OfertaDetallesPage(),
    'edit':(BuildContext context) =>  EditPage()



    
  
  };
}