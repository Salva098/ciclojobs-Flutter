

import 'dart:io';

import 'package:ciclojobs/src/models/tipociclo.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';

class TipoCicloService{
  final AuthHttpClient authHttpClient = AuthHttpClient();

  final urlServer = "http://51.254.98.153";
  final controller = "/api/TipoCiclo";
  
Future<List<TipoCiclo>> getAllTipoCiclos() async {
    final resq = await authHttpClient.get(
        Uri.parse(urlServer+controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return tipocicloFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }



}