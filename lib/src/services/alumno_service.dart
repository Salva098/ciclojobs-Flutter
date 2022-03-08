import 'dart:convert';
import 'dart:io';

import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';


class AlumnoService {
  final urlapi = "http://51.254.98.153";
  final controller = "/api/Alumno";
  final AuthHttpClient authHttpClient = AuthHttpClient();

  Future<String> login(String email, String password) async {
    final resq = await authHttpClient.post(Uri.parse(urlapi + controller + "/Login"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(
            <String, String>{"email": email, "contrasena": password}));

    if (resq.statusCode == 200) {
      return resq.headers['token'].toString();
    } else {
      return "";
    }
  }

  Future<bool> register(Alumno alumno) async {
    final resq = await authHttpClient.post(Uri.parse(urlapi + controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(alumno.toJson()));
    if (resq.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getAlumno() async {
    final resq = await authHttpClient.get(Uri.parse(urlapi + controller +"/ID"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode == 200) {
        return alumnoFromJson(resq.body);
    }
  }

  Future<bool> enviarEmail(String email) async {
      final resq = await authHttpClient.post(Uri.parse(urlapi + controller +"/GenerarCode?email="+email),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (resq.statusCode == 200) {
          return true;
      }else{
        return false;
      }
  }
  Future<bool> checkAccount(String email) async {
    final resq = await authHttpClient.post(Uri.parse(urlapi + controller +"/CheckAccount?email="+email),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (resq.statusCode == 200) {
          return true;
      }else{
        return false;
      }
  }
  Future<bool> checkCode(String email,String code) async {
      final resq = await authHttpClient.post(Uri.parse(urlapi + controller +"/VerificarAccount?email="+email+"&code="+code),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (resq.statusCode == 200) {
          return true;
      }else{
        return false;
      }
  }
  Future<bool> changepassword(String email,String password) async {
    final resq = await authHttpClient.get(Uri.parse(urlapi + controller +"/Email?email="+email),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (resq.statusCode == 200) {
        Alumno alumno = alumnoFromJson(resq.body);
        alumno.contrasena=password;
        final resq2 = await authHttpClient.put(Uri.parse(urlapi + controller),
        body: alumnoToJson(alumno),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
              if (resq2.statusCode==200) {
                return true;
              } else {
                return false;
              }
      }else{
        return false;
      }
  }

  Future<bool> editarPerfil(Alumno alumno) async {
    final resq = await authHttpClient.get(Uri.parse(urlapi + controller +"/Email?email="+alumno.email),
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (resq.statusCode == 200) {

        Alumno a = alumnoFromJson(resq.body);
        alumno.id=a.id;
    final resq1 = await authHttpClient.put(Uri.parse(urlapi + controller),body:alumnoToJson(alumno) ,
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});
            if(resq1.statusCode==200){
              return true;
            }else{
              return false;
            }
          }else{
            return false;
          }
  }

}
