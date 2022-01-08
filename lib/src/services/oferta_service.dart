import 'dart:io';

import 'package:ciclojobs/src/models/ofertas.dart';
import 'package:http/http.dart' as http;

class OfertasService{
  final urlServer = "http://10.0.2.2:5000";
  final controller = "/api/Oferta";
 
 Future<List<Ofertas>> getOfertas(String idCiclo) async {
   print(urlServer + controller+"/Ciclo/"+idCiclo);
   final resq = await http.get(Uri.parse(urlServer + controller+"/Ciclo/"+idCiclo),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return ofertasFromJson(resq.body);
    } else {
      return [];
    }
 }
}