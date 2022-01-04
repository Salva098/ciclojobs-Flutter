
import 'dart:convert';

Alumno alumnoFromJson(String str) => Alumno.fromJson(json.decode(str));

String alumnoToJson(Alumno data) => json.encode(data.toJson());

class Alumno {
    Alumno(
        this.email,{
        this.contrasena,
        this.id,
        this.nombre,
        this.apellidos,
        this.fechanacimiento,
        this.idprovincias,
        this.localidad,
        this.idCiclo,
        this.calificacionMedia,
        this.foto,
        });
    

    String email;
    String? contrasena;
    int? id;
    String? nombre;
    String? apellidos;
    DateTime? fechanacimiento;
    int? idprovincias;
    String? localidad;
    int? idCiclo;
    double? calificacionMedia;
    String? foto;

    factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        json["email"],
        contrasena: json["contrasena"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        fechanacimiento : DateTime.parse(json["fechanacimiento"]),
        idprovincias : json["idprovincias"],
        localidad : json["localidad"],
        idCiclo : json["id_ciclo"],
        calificacionMedia :  json["calificacion_media"].toDouble(),
        foto : json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "contrasena": contrasena,
        "nombre": nombre,
        "apellidos": apellidos,
        "fechanacimiento": fechanacimiento!.toIso8601String(),
        "idprovincias": idprovincias,
        "localidad": localidad,
        "id_ciclo": idCiclo,
        "calificacion_media": calificacionMedia,
        "foto": foto,
    };
}
