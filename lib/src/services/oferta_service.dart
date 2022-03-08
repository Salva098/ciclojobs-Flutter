import 'dart:io';

import 'package:ciclojobs/src/models/ofertas.dart';
import 'package:ciclojobs/src/services/AuthHttpClient.dart';


class OfertasService{
final AuthHttpClient authHttpClient = AuthHttpClient();
  final urlServer = "https://www.ciclojobs.ml";
  final controller = "/api/Oferta";
 
 Future<List<Ofertas>> getOfertas(String idCiclo) async {
   final resq = await authHttpClient.get(Uri.parse(urlServer + controller+"/NoCaducado/"+idCiclo),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (resq.statusCode==200) {
    return ofertasFromJson(resq.body);
    } else {
      return [];
    }
 }
}