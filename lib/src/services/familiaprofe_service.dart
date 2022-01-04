import 'dart:io';

import 'package:ciclojobs/src/models/familia.dart';
import 'package:http/http.dart' as http;
class FamiliaProfeService{
  final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/FamiliaProfe";

Future<List<Familia>> getFamiliaProfe(int id) async {
    final resq = await http.get(
        Uri.parse(urlServer+controller+"/"+id.toString()),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return familiaFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }
}