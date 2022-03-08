import 'package:ciclojobs/src/models/mensaje.dart';
import 'package:ciclojobs/src/pages/inscripcion_page.dart';
import 'package:ciclojobs/src/pages/ofertas_page.dart';
import 'package:ciclojobs/src/pages/profile_page.dart';
import 'package:ciclojobs/src/services/inscipciones_service.dart';
import 'package:ciclojobs/src/services/mensaje_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final screens = [
    const OfertasPage(),
    const InscripcionPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {

Future.delayed(Duration.zero, () => alerts(context));  
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.home),
            //     label: "Home",
            //     backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: "Ofertas",
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.all_inbox),
                label: "Mis inscripciones",
                backgroundColor: Colors.brown),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Perfil",
                backgroundColor: Colors.green)
          ],
        ),
      ),
    );
  }

  void alerts(BuildContext context) {
    List<Widget> alerts=[];
    MensajeService().mensajesNoLeido().then((value) => {

      recursiveAlerts(value,0,context)
    }
    );


    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             content: Text("hi"),
    //           ));
    }
    Future<void> recursiveAlerts(List<Mensajes> mensajes, int index,BuildContext context) async {
    if (index >= mensajes.length) {
      return;
    }else{

      print(mensajes[index].id);
     await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
      title: Text('Mensaje de '+mensajes[index].empresa.nombre),
      content: Text(mensajes[index].mensaje),
      actions: [
        TextButton(
          onPressed: () {
            MensajeService().LeerMensaje(mensajes[index].id.toString()).then((value) => {

            if(value){
              
            Navigator.pop(_)
            }
            });

          },
          child: const Text('Leido'),
        ),
      ],
    );

      });

    recursiveAlerts(mensajes,index+1,context);
    }

    }
}
