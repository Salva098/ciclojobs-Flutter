import 'dart:convert';

import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/models/ofertas.dart';

List<Inscripciones> inscripcionesFromJson(String str) =>
    List<Inscripciones>.from(
        json.decode(str).map((x) => Inscripciones.fromJson(x)));

Inscripciones inscripcionFromJson(String str) =>
    Inscripciones.fromJson(json.decode(str));

String inscripcionesToJson(Inscripciones data) => json.encode(data.toJson());

class Inscripciones {
  Inscripciones(this.idAlumno, this.ofertaId, this.fechaInscripcion,
      this.estadoInscripcin,
      {this.id, this.alumno, this.oferta});
  int? id;
  Alumno? alumno;
  Ofertas? oferta;
  int idAlumno;
  int ofertaId;
  DateTime fechaInscripcion;
  String estadoInscripcin;

  factory Inscripciones.fromJson(Map<String, dynamic> json) => Inscripciones(
      json["idAlumno"],
      json["ofertaId"],
      DateTime.parse(json["fechaInscripcion"]),
      json["estadoInscripción"],
      id: json["id"],
      alumno: Alumno.fromJson(json["alumno"]),
      oferta: Ofertas.fromJson(json["oferta"]));
  Map<String, dynamic> toJson() => {
        "id": id,
        "idAlumno": idAlumno,
        "alumno": alumno?.toJson(),
        "ofertaId": ofertaId,
        "oferta": oferta?.toJson(),
        "fechaInscripcion": fechaInscripcion.toIso8601String(),
        "estadoInscripción": estadoInscripcin,
      };
}
