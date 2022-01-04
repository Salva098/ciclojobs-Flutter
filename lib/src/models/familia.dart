
import 'dart:convert';
List<Familia> familiaFromJson(String str) => List<Familia>.from(json.decode(str).map((x) => Familia.fromJson(x)));

String familiaToJson(List<Familia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Familia {
    Familia(
        this.idprofe,
        this.nombre,
    );

    int idprofe;
    String nombre;

    factory Familia.fromJson(Map<String, dynamic> json) => Familia( json["idprofe"],json["nombre"]);

    Map<String, dynamic> toJson() => {
        "idprofe": idprofe,
        "nombre": nombre,
    };
}