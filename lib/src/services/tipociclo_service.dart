

import 'dart:io';

import 'package:ciclojobs/src/models/tipociclo.dart';
import 'package:http/http.dart' as http;

class TipoCicloService{
  final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/TipoCiclo";
  
Future<List<TipoCiclo>> getAllTipoCiclos() async {
    final resq = await http.get(
        Uri.parse(urlServer+controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return tipocicloFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }



}