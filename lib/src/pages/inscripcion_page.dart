import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/models/inscipciones.dart';
import 'package:ciclojobs/src/models/ofertas.dart';
import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:ciclojobs/src/services/inscipciones_service.dart';
import 'package:ciclojobs/src/services/oferta_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InscripcionPage extends StatefulWidget {
  InscripcionPage({Key? key}) : super(key: key);

  @override
  _InscripcionPageState createState() => _InscripcionPageState();
}

class _InscripcionPageState extends State<InscripcionPage> {
  String idciclo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color(0xffdbdbdb),
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("Mis inscipciones"),
        ),
        body: FutureBuilder(
            future: InscipcioneService().getInscripcionesAlumno(dotenv.env['ID_ALUMNO'] ?? "a"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Widget> items = [const SizedBox(height: 10,)];


                for (Inscripciones insc in snapshot.data) {
                  items.add(Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Image.network(
                              'https://www.taqt.com/build/images/brands/logocompanies/carrefour_logo.7d2f4139.webp'),
                          title: Text(insc.oferta!.nombre),
                          subtitle: Column(
                            children: [
                              ListTile(
                                title: const Text("Descripcion"),
                                subtitle: Text(insc.oferta!.descripcion),
                              ),
                               
                              
                            ],
                          ),
                        ),
                        Text("Estado Inscripcion: " +insc.estadoInscripcion),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'ofertas',
                                      arguments:insc.oferta) .then((_) => setState((){}));
                                },
                                child: const Text("Ver detalles"))
                          ],
                        )
                      ],
                    ),
                  ));
                }
                return ListView(
                  children: items,
                );
              } else if (snapshot.hasError) {
                return const Text("ERROR");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<List<Ofertas>> getofertas() async {
    return await AlumnoService()
        .getAlumno(dotenv.env['ID_ALUMNO'] ?? "a")
        .then((alumno) async {
      if (alumno is Alumno) {
        return await OfertasService()
            .getOfertas(alumno.ciclo!.id.toString())
            .then((value) {
          return value;
        });
      } else {
        return [];
      }
    });
  }
}
