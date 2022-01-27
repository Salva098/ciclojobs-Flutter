import 'dart:io';
import 'package:ciclojobs/src/models/provincias.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';



class ProvinciasServices {
  final AuthHttpClient authHttpClient = AuthHttpClient();

  final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/Provincias";
  Future<List<Provincias>> getProvincias() async {
    final resq = await authHttpClient.get(
        Uri.parse(urlServer+controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return provinciasFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }
}
