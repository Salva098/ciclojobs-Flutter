import 'dart:convert';

List<Provincias> provinciasFromJson(String str) => List<Provincias>.from(json.decode(str).map((x) => Provincias.fromJson(x)));

String provinciasToJson(List<Provincias> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Provincias {

    int id;
    String provincias;
    Provincias(
         this.id,
         this.provincias,
    );

    factory Provincias.fromJson(Map<String, dynamic> json) => Provincias(json["id"],json["provincias"]);

    Map<String, dynamic> toJson() => {
        "id": id,
        "provincias": provincias,
    };
}