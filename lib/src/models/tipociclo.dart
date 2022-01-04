

import 'dart:convert';

List<TipoCiclo> tipocicloFromJson(String str) => List<TipoCiclo>.from(json.decode(str).map((x) => TipoCiclo.fromJson(x)));

String tipocicloToJson(List<TipoCiclo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class TipoCiclo {
    TipoCiclo(
        this.idtipo,
        this.nombre,
    );

    int idtipo;
    String nombre;

    factory TipoCiclo.fromJson(Map<String, dynamic> json) => TipoCiclo(json["idtipo"],json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "idtipo": idtipo,
        "nombre": nombre,
    };
}
