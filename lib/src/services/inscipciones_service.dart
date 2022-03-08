
import 'dart:convert';
import 'dart:io';

import 'package:ciclojobs/src/models/inscipciones.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';

class InscipcioneService{
  final AuthHttpClient authHttpClient = AuthHttpClient();

    final urlServer = "http://51.254.98.153";
  final controller = "/api/Inscripciones";

  Future<int> checkinscipcion(String idOferta) async {

  final resq = await authHttpClient.get(Uri.parse(urlServer + controller+"/CheckAlumno/"+idOferta),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return int.parse(resq.body);
    } else {
      return -1;
    }
  } 
  Future<int> crearInscripcion(Inscripciones inscripcion) async{

    final resq = await authHttpClient.post(Uri.parse(urlServer + controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.acceptHeader: 'application/json'},
        body: jsonEncode(inscripcion.toJson()));
    if (resq.statusCode==200) {
    return int.parse(resq.body);
    } else {
      return -1;
    }
  }
  Future<List<Inscripciones>> getInscripcionesAlumno(String id) async {
    final resq = await authHttpClient.get(Uri.parse(urlServer + controller+"/Alumno"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return inscripcionesFromJson(resq.body);
    } else {
      return [];
    }
  }
  Future<bool> eliminarInscripcion(int inscripcion) async{
    final resq = await authHttpClient.delete(Uri.parse(urlServer + controller+"?id="+inscripcion.toString()),
        headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.acceptHeader: 'application/json'},);
    if (resq.statusCode==200) {
    return true;
    } else {
      return false;
    }
  }
}