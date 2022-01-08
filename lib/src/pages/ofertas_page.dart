import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/models/ofertas.dart';
import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:ciclojobs/src/services/oferta_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OfertasPage extends StatefulWidget {
  OfertasPage({Key? key}) : super(key: key);

  @override
  _OfertasPageState createState() => _OfertasPageState();
}

class _OfertasPageState extends State<OfertasPage> {
  String idciclo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Ofertas"),
        ),
        body: FutureBuilder(
            future: getofertas(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Widget> items = [const SizedBox(height: 10,)];
                for (Ofertas ofertas in snapshot.data) {
                  items.add(Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Image.network(
                              'https://www.taqt.com/build/images/brands/logocompanies/carrefour_logo.7d2f4139.webp'),
                          title: Text(ofertas.nombre),
                          subtitle: ListTile(
                            title: const Text("Descripcion"),
                            subtitle: Text(ofertas.descripcion),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'ofertas',
                                      arguments: ofertas);
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
