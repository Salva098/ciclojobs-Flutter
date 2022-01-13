import 'dart:convert';
import 'dart:io';

import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:http/http.dart' as http;

class AlumnoService {
  final urlapi = "http://10.0.2.2:5000";
  final controller = "/api/Alumno";
  Future<int> login(String email, String password) async {
    final resq = await http.post(Uri.parse(urlapi + controller + "/Login"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(
            <String, String>{"email": email, "contrasena": password}));
    if (resq.statusCode == 200) {
      return int.parse(resq.body);
    } else {
      return -1;
    }
  }

  Future<bool> register(Alumno alumno) async {
    final resq = await http.post(Uri.parse(urlapi + controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(alumno.toJson()));
    if (resq.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getAlumno(String id) async {
    final resq = await http.get(Uri.parse(urlapi + controller +"/"+ id),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode == 200) {
        return alumnoFromJson(resq.body);
    }
  }

}
