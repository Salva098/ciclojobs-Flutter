// To parse this JSON data, do
//
//     final ofertas = ofertasFromJson(jsonString);

import 'dart:convert';

import 'package:ciclojobs/src/models/ciclos.dart';

import 'empresas.dart';

List<Ofertas> ofertasFromJson(String str) => List<Ofertas>.from(json.decode(str).map((x) => Ofertas.fromJson(x)));

String ofertasToJson(List<Ofertas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ofertas {
    Ofertas(
        this.id,
        this.nombre,
        this.descripcion,
        this.remuneracion,
        this.fechaInicio,
        this.fechaFin,
        this.horario,
        this.idempresas,
        this.empresas,
        this.ciclo,
    );

    int id;
    String nombre;
    String descripcion;
    int remuneracion;
    DateTime fechaInicio;
    DateTime fechaFin;
    String horario;
    int idempresas;
    Empresas empresas;
    List<Ciclo> ciclo;

    factory Ofertas.fromJson(Map<String, dynamic> json) => Ofertas(
json["id"],
 json["nombre"],
json["descripcion"],
json["remuneracion"],
 DateTime.parse(json["fecha_inicio"]),
DateTime.parse(json["fecha_fin"]),
json["horario"],
 json["idempresas"],
Empresas.fromJson(json["empresas"]),
List<Ciclo>.from(json["ciclo"].map((x) => Ciclo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "remuneracion": remuneracion,
        "fecha_inicio": fechaInicio.toIso8601String(),
        "fecha_fin": fechaFin.toIso8601String(),
        "horario": horario,
        "idempresas": idempresas,
        "empresas": empresas.toJson(),
        "ciclo": List<dynamic>.from(ciclo.map((x) => x.toJson())),
    };
}





