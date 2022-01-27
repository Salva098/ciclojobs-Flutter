import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/models/ofertas.dart';
import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:ciclojobs/src/services/oferta_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class OfertasPage extends StatefulWidget {
  const OfertasPage({Key? key}) : super(key: key);

  @override
  _OfertasPageState createState() => _OfertasPageState();
}

class _OfertasPageState extends State<OfertasPage> {
  String idciclo = "";
  String busqueda = "";
  @override
  Widget build(BuildContext context) {
    List<Ofertas> _ofertas = [];
    return Scaffold(
      backgroundColor: const Color(0xffdbdbdb),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Ofertas"),
      ),
      body: FutureBuilder(
          future: getofertas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Widget> items = [
                const SizedBox(
                  height: 10,
                )
              ];
              _ofertas = snapshot.data as List<Ofertas>;
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
              return Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView(
                      children: items,
                    ),
                  ),
                  buildSearchBar(_ofertas)
                ],
              );
            } else if (snapshot.hasError) {
              return const Text("ERROR");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List<Ofertas>> getofertas() async {
    return await AlumnoService()
        .getAlumno()
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

  Widget buildSearchBar(List<Ofertas> ofertas) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    List<Ofertas> ofertasFiltradas = ofertas;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        setState(() {
          busqueda = query;
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: SlideFadeFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        List<Widget> lista = [];
        var filtro = ofertasFiltradas
            .where((element) => element.nombre.contains(busqueda))
            .toList();
        for (Ofertas item in filtro) {
          lista.add(ListTile(
              title: Text(item.nombre),
              subtitle: Text(item.empresas.nombre),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'ofertas', arguments: item);
                },
                icon: const Icon(Icons.arrow_forward_ios),
              )));
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: lista,
            ),
          ),
        );
      },
    );
  }
}
