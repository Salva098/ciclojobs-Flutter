import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:AlumnoService().getAlumno(dotenv.env['ID_ALUMNO']??"aaaaaaa") ,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            
         
        Alumno _alumno=snapshot.data;
        return Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Image.network(
                      "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _alumno.nombre??"No existe",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _alumno.email,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 3,
                  )
                ],
              ),
              const Divider(),
              Container(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Información de alumno".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               ListTile(
                title: const Text(
                  "Nombre",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  _alumno.nombre ?? " No existe",
                ),
              ),
              ListTile(
                title: const Text(
                  "Apellidos",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  _alumno.apellidos ?? " No existe",
                ),
              ),
              ListTile(
                title: const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  _alumno.email,
                ),
              ),
              const ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  "jane@doefamily.com",
                ),
              ),
              const ListTile(
                title: Text(
                  "Phone",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  "+1 816-926-6241",
                ),
              ),
              const ListTile(
                title: Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  "1278 Loving Acres RoadKansas City, MO 64110",
                ),
              ),
            
            ],
          ),
        );
        }else{
          return const CircularProgressIndicator();
        }
        }
      ),
    );
  }
}
