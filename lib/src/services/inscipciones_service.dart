
import 'dart:convert';
import 'dart:io';

import 'package:ciclojobs/src/models/inscipciones.dart';
import 'package:http/http.dart' as http;

class InscipcioneService{
    final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/Inscripciones";

  Future<int> checkinscipcion(String idAlumno,String idOferta) async {

  final resq = await http.get(Uri.parse(urlServer + controller+"/Alumno/"+idAlumno+"/"+idOferta),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return int.parse(resq.body);
    } else {
      return -1;
    }
  } 
  Future<int> crearInscripcion(Inscripciones inscripcion) async{

    final resq = await http.post(Uri.parse(urlServer + controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.acceptHeader: 'application/json'},
        body: jsonEncode(inscripcion.toJson()));
    if (resq.statusCode==200) {
    return int.parse(resq.body);
    } else {
      return -1;
    }
  }
  Future<List<Inscripciones>> getInscripcionesAlumno(String id) async {
    final resq = await http.get(Uri.parse(urlServer + controller+"/Alumno/"+id),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return inscripcionesFromJson(resq.body);
    } else {
      return [];
    }
  }
  Future<bool> eliminarInscripcion(int inscripcion) async{
    final resq = await http.delete(Uri.parse(urlServer + controller+"?id="+inscripcion.toString()),
        headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.acceptHeader: 'application/json'},);
    if (resq.statusCode==200) {
    return true;
    } else {
      return false;
    }
  }
}