import 'dart:io';

import 'package:ciclojobs/src/models/familia.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';

class FamiliaProfeService{
  final AuthHttpClient authHttpClient = AuthHttpClient();

  final urlServer = "http://51.254.98.153";
  final controller = "/api/FamiliaProfe";

Future<List<Familia>> getFamiliaProfe(int id) async {
    final resq = await authHttpClient.get(
        Uri.parse(urlServer+controller+"/"+id.toString()),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return familiaFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }
}