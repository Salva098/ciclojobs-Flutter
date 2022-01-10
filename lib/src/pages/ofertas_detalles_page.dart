import 'package:carousel_slider/carousel_slider.dart';
import 'package:ciclojobs/src/models/ciclos.dart';
import 'package:ciclojobs/src/models/inscipciones.dart';
import 'package:ciclojobs/src/models/ofertas.dart';
import 'package:ciclojobs/src/services/inscipciones_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OfertaDetallesPage extends StatefulWidget {
  const OfertaDetallesPage({Key? key}) : super(key: key);

  @override
  _OfertaDetallesPageState createState() => _OfertaDetallesPageState();
}

class _OfertaDetallesPageState extends State<OfertaDetallesPage> {
  bool isFav = false;
  int idinscripcion = 0;
  List<Widget> items = [];
  @override
  Widget build(BuildContext context) {
    final Ofertas oferta =
        ModalRoute.of(context)!.settings.arguments as Ofertas;
    final AlertDialog dialog = AlertDialog(
      title: const Text('Salir de la inscripcion'),
      content: const Text('¿Estas seguro que quieres salir de la inscripcion?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            InscipcioneService()
                .eliminarInscripcion(idinscripcion)
                .then((value) {
              if (value) {
                setState(() {
                  isFav = false;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Inscripcion eliminada")));
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al eliminar")));
              }
            });
          },
          child: const Text('ACCEPT'),
        ),
      ],
    );
    for (Ciclo c in oferta.ciclo) {
      items.add(
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.lightBlueAccent,
          child: Center(
            child: ListTile(
              title: Text(c.nombre,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Column(
                children: [
                  Text("Familia: " + c.familia.nombre,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("Tipo Ciclo: " + c.tipoCiclo.nombre,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () { 
             Navigator.pop(context);
             },
        ),
        centerTitle: true,
        title: const Text("Detalles de Oferta"),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: [
            const SizedBox(height: 10.0),
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://www.taqt.com/build/images/brands/logocompanies/carrefour_logo.7d2f4139.webp',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              oferta.nombre,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: [
                  Text(
                    oferta.remuneracion.toString() + " €",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Horario de la oferta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            Text(
              oferta.horario,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Duración Oferta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            Text(
              oferta.fechaInicio.toString().split(" ")[0] +
                  " -> " +
                  oferta.fechaFin.toString().split(" ")[0],
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Descripcion de la Oferta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            Text(
              oferta.descripcion,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Ciclos de la oferta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 100.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                viewportFraction: 0.8,
              ),
              items: items,
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Empresa de la oferta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    "https://www.cabronews.com/wp-content/uploads/2020/11/IMG-20201109-WA0017.jpg"),
              ),
              title: Text(
                oferta.empresas.nombre,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                oferta.empresas.email,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!isFav) {
              DateTime now = DateTime.now();
              InscipcioneService()
                  .crearInscripcion(Inscripciones(
                      int.parse(dotenv.env['ID_ALUMNO'] ?? "0"),
                      oferta.id,
                      now,
                      "pendiente"))
                  .then((value) => setState(() {
                        if (value != -1) {
                          idinscripcion = value;
                          isFav = true;
                        } else {
                          isFav = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Error al inscribirse")));
                        }
                      }));
            } else {
              showDialog(
                  context: context,
                  builder: (_) {
                    return dialog;
                  });
            }
          },
          child: FutureBuilder(
              future: InscipcioneService().checkinscipcion(
                  dotenv.env['ID_ALUMNO'] ?? "a", oferta.id.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != -1) {

                    idinscripcion = snapshot.data;
                    isFav = true;

                    return const Icon(Icons.person_off);
                  } else {
                    isFav = false;
                    return const Icon(Icons.person_add_alt_1);
                  }
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error);
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
