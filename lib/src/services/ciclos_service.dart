import 'dart:io';
import 'package:ciclojobs/src/models/ciclos.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';
class CiclosService{
final AuthHttpClient authHttpClient = AuthHttpClient();

final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/Ciclo";
  Future<List<Ciclo>> getAllCiclos() async {
    final resq = await authHttpClient.get(
        Uri.parse(urlServer+controller),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return ciclosFromJson(resq.body);
    } else {
      throw Exception("Error al cargar los datos");
    }
  }
  Future<List<Ciclo>> getCiclo(int tipo,int familia) async {
    final resq = await authHttpClient.get(
        Uri.parse(urlServer+controller+"/"+tipo.toString()+"/"+familia.toString()),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (resq.statusCode == 200) {
      return ciclosFromJson(resq.body);
    } else {
      return [];
    }
  }

}