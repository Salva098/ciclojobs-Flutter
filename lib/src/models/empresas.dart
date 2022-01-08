
import 'package:ciclojobs/src/models/provincias.dart';

class Empresas {
    Empresas(
        this.id,
        this.email,
        this.nombre,
        this.idprovincias,
        this.provincias,
        this.localidad,
        this.direccion,
    );

    int id;
    String email;
    String nombre;
    int idprovincias;
    Provincias provincias;
    String localidad;
    String direccion;

    factory Empresas.fromJson(Map<String, dynamic> json) => Empresas(
 json["id"],
json["email"],
json["nombre"],
json["idprovincias"],
 Provincias.fromJson(json["provincias"]),
json["localidad"],
json["direccion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nombre": nombre,
        "idprovincias": idprovincias,
        "provincias": provincias.toJson(),
        "localidad": localidad,
        "direccion": direccion,
    };
}