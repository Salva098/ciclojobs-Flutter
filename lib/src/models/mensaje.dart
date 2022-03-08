// To parse this JSON data, do
//
//     final mensajes = mensajesFromJson(jsonString);

import 'dart:convert';

import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/models/empresas.dart';

List<Mensajes> mensajesFromJson(String str) => List<Mensajes>.from(json.decode(str).map((x) => Mensajes.fromJson(x)));

String mensajesToJson(List<Mensajes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mensajes {
    Mensajes(
        this.id,
        this.alumnoid,
        this.alumno,
        this.empresaid,
        this.empresa,
        this.mensaje,
        this.leido,
    );

    int id;
    int alumnoid;
    Alumno alumno;
    int empresaid;
    Empresas empresa;
    String mensaje;
    bool leido;

    factory Mensajes.fromJson(Map<String, dynamic> json) => Mensajes( json["id"], json["alumnoid"], Alumno.fromJson(json["alumno"]),json["empresaid"],Empresas.fromJson(json["empresa"]),json["mensaje"],json["leido"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "alumnoid": alumnoid,
        "alumno": alumno.toJson(),
        "empresaid": empresaid,
        "empresa": empresa.toJson(),
        "mensaje": mensaje,
        "leido": leido,
    };
}