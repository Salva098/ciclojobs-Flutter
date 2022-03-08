
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ciclojobs/src/models/inscipciones.dart';
import 'package:ciclojobs/src/models/mensaje.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';

class MensajeService{
  final AuthHttpClient authHttpClient = AuthHttpClient();

    final urlServer = "https://www.ciclojobs.ml";
  final controller = "/api/Mensajes";
Future<List<Mensajes>> mensajesNoLeido() async {

  final resq = await authHttpClient.get(Uri.parse(urlServer + controller+"/NoLeidos"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return mensajesFromJson(resq.body);
    } else {
      return [];
    }
  } 
  Future<bool> LeerMensaje(String mensajeid) async {

  final resq = await authHttpClient.post(Uri.parse(urlServer + controller+"/LeerMensaje?idmensaje="+mensajeid),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return true;
    } else {
      return false;
    }
  } 

}