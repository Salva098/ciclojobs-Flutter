import 'dart:io';
import 'package:ciclojobs/src/models/provincias.dart';
import 'package:http/http.dart' as http;


class ProvinciasServices {
  final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/Provincias";
  Future<List<Provincias>> getProvincias() async {
    final resq = await http.get(
        Uri.parse(urlServer+controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return provinciasFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }
}
