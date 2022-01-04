import 'dart:convert';
import 'package:ciclojobs/src/models/familia.dart';
import 'package:ciclojobs/src/models/tipociclo.dart';

List<Ciclo> ciclosFromJson(String str) => List<Ciclo>.from(json.decode(str).map((x) => Ciclo.fromJson(x)));

String ciclosToJson(List<Ciclo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Ciclo cicloFromJson(String str) => Ciclo.fromJson(json.decode(str));

String cicloToJson(Ciclo data) => json.encode(data.toJson());

class Ciclo {
    Ciclo(
        this.id,
        this.nombre,
        this.idfamiliaprofe,
        this.familia,
        this.idtipo,
        this.tipoCiclo,
    );

    int id;
    String nombre;
    int idfamiliaprofe;
    Familia familia;
    int idtipo;
    TipoCiclo tipoCiclo;

    factory Ciclo.fromJson(Map<String, dynamic> json) => Ciclo(json["id"],json["nombre"],json["idfamiliaprofe"],Familia.fromJson(json["familia"]),json["idtipo"],TipoCiclo.fromJson(json["tipoCiclo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "idfamiliaprofe": idfamiliaprofe,
        "familia": familia.toJson(),
        "idtipo": idtipo,
        "tipoCiclo": tipoCiclo.toJson(),
    };
}


