import 'package:ciclojobs/src/models/alumnos.dart';
import 'package:ciclojobs/src/models/ciclos.dart';
import 'package:ciclojobs/src/models/familia.dart';
import 'package:ciclojobs/src/models/provincias.dart';
import 'package:ciclojobs/src/models/tipociclo.dart';
import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:ciclojobs/src/services/ciclos_service.dart';
import 'package:ciclojobs/src/services/familiaprofe_service.dart';
import 'package:ciclojobs/src/services/provincias_service.dart';
import 'package:ciclojobs/src/services/tipociclo_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _repetircontrasenaController = TextEditingController();
  final _localidadController = TextEditingController();
  final _calificacionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime currentDate = DateTime.now();
  int _provinciavalue = 1;
  int _familiaProfesionalValue = 1;
  int _tipoGradoValue = 1;
  int _cicloCursadoValue = 1;

  Map _dropDownProvinciasMap = {};
  Map _dropDownFamiliaProfeMap = {};
  Map _dropDownTipoCicloMap = {};
  Map _dropDownCiclosMap = {};

  List<DropdownMenuItem<Provincias>> listaProvincias = [];
  List<DropdownMenuItem<Familia>> listaFamiliaProfe = [];
  List<DropdownMenuItem<TipoCiclo>> listaTipoCiclo = [];
  List<DropdownMenuItem<Ciclo>> listaCiclos = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF035860), Color(0xFF24476F)])),
          height: height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * .2),
                      _title(),
                      const SizedBox(height: 50),
                      _formregister(),
                      const SizedBox(height: 20),
                      _submitButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "CicloJobs",
        style: GoogleFonts.dosis(
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _formregister() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _entryField("Nombre"),
          _entryField("Apellidos"),
          _entryField("Email"),
          _entryField("Contrasena", contrasena: true),
          _entryField("Repetir Contrasena", contrasena: true),
          _datepikerbutton(),
          _dropDown('Provincia'),
          _entryField('Localidad'),
          _dropDown('Tipo de grado'),
          _dropDown('Familia Profesional'),
          _dropDown('Ciclo Cursado'),
          _entryField('Calificacion media del ciclo', decial: true)
        ],
      ),
    );
  }

  Widget _dropDown(String titulo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.blue[500],  ),
            child: DropdownButtonHideUnderline(
                child: FutureBuilder(
              future: _getFutures(titulo),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Text('algo no va bien');
                } else if (snapshot.hasData) {
                  if (snapshot.data is List<Familia>) {
                    listaFamiliaProfe.clear();
                    _dropDownFamiliaProfeMap = {};
                    snapshot.data.forEach((Familia familiaItem) => {
                          _dropDownFamiliaProfeMap[familiaItem.idprofe] =
                              familiaItem.nombre,
                          listaFamiliaProfe.add(DropdownMenuItem(
                            child: Text(familiaItem.nombre),
                            value: familiaItem,
                          ))
                        });
                    return InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        fillColor: const Color(0xfff3f3f4),
                      ),
                      child: DropdownButton<Familia>(
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white),
                        hint: Text(
                          _dropDownFamiliaProfeMap.values.elementAt(
                              _dropDownFamiliaProfeMap.keys.toList().indexWhere(
                                          (e) =>
                                              e == _familiaProfesionalValue) ==
                                      -1
                                  ? 0
                                  : _dropDownFamiliaProfeMap.keys
                                      .toList()
                                      .indexWhere((e) =>
                                          e == _familiaProfesionalValue)),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        items: listaFamiliaProfe,
                        onChanged: (Familia? select) {
                          setState(() {
                            _setValue(titulo, select!.idprofe);
                          });
                        },
                      ),
                    );
                  } else if (snapshot.data is List<Provincias>) {
                    listaProvincias.clear();
                    _dropDownProvinciasMap = {};
                    snapshot.data.forEach((Provincias provinciaItem) => {
                          _dropDownProvinciasMap[provinciaItem.id] =
                              provinciaItem.provincias,
                          listaProvincias.add(DropdownMenuItem(
                            child: Text(provinciaItem.provincias),
                            value: provinciaItem,
                          ))
                        });
                    return InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        fillColor: const Color(0xfff3f3f4),
                      ),
                      child: DropdownButton<Provincias>(
                        style: const TextStyle(color: Colors.white),
                        hint: Text(
                          _dropDownProvinciasMap.values
                              .elementAt(_getValue(titulo) - 1),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        items: listaProvincias,
                        onChanged: (Provincias? select) {
                          setState(() {
                            _setValue(titulo, select!.id);
                          });
                        },
                      ),
                    );
                  } else if (snapshot.data is List<TipoCiclo>) {
                    listaTipoCiclo.clear();
                    _dropDownTipoCicloMap = {};
                    snapshot.data.forEach((TipoCiclo tipocicloitem) => {
                          _dropDownTipoCicloMap[tipocicloitem.idtipo] =
                              tipocicloitem.nombre,
                          listaTipoCiclo.add(DropdownMenuItem(
                            child: Text(tipocicloitem.nombre),
                            value: tipocicloitem,
                          ))
                        });
                    return InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        fillColor: const Color(0xfff3f3f4),
                      ),
                      child: DropdownButton<TipoCiclo>(
                        style:const TextStyle(color: Colors.white),
                        hint: Text(
                          _dropDownTipoCicloMap.values
                              .elementAt(_getValue(titulo) - 1),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        items: listaTipoCiclo,
                        onChanged: (TipoCiclo? select) {
                          setState(() {
                            _setValue(titulo, select!.idtipo);
                            if (_tipoGradoValue == 4) {
                              _familiaProfesionalValue = 7;
                            } else {
                              _familiaProfesionalValue = 1;
                            }
                          });
                        },
                      ),
                    );
                  } else if (snapshot.data is List<Ciclo>) {
                    listaCiclos = [];
                    _dropDownCiclosMap = {};

                    snapshot.data.forEach((Ciclo cicloitem) => {
                          _dropDownCiclosMap[cicloitem.id] = cicloitem.nombre,
                          listaCiclos.add(DropdownMenuItem(
                            child: Text(cicloitem.nombre),
                            value: cicloitem,
                          ))
                        });

                    return InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        fillColor: const Color(0xfff3f3f4),
                      ),
                      child: DropdownButton<Ciclo>(
                        style: const TextStyle(color: Colors.white),
                        isExpanded: true,
                        hint: Text(
                          _dropDownCiclosMap.values.elementAt(_dropDownCiclosMap
                                      .keys
                                      .toList()
                                      .indexWhere(
                                          (e) => e == _cicloCursadoValue) ==
                                  -1
                              ? 0
                              : _dropDownCiclosMap.keys
                                  .toList()
                                  .indexWhere((e) => e == _cicloCursadoValue)),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        items: listaCiclos,
                        onChanged: (Ciclo? select) {
                          setState(() {
                            _setValue(titulo, select!.id);
                          });
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _datepikerbutton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Birthday",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              currentDate = DateTime.now();
              _selectDate(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: Text(
                DateFormat('dd/MM/yyyy').format(currentDate),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: currentDate);
    if (pickDate != null && pickDate != currentDate) {
      setState(() {
        currentDate = pickDate;
      });
    }
  }

  Widget _entryField(String titulo,
      {bool contrasena = false, bool decial = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          _textField(contrasena, decial,titulo)
        ],
      ),
    );
  }

  TextFormField _textField(bool contrasena, bool decimal,String titulo) {
    if (decimal) {
      return TextFormField(
        validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
        controller: _getController(titulo),
        style: const TextStyle(color: Colors.white),
        obscureText: contrasena,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
               fontSize: 20,
               color: Colors.redAccent
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          fillColor: const Color(0xfff3f3f4),
        ),
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
      );
    } else {
      return TextFormField(
        validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              if(titulo=="Email"){

                if (!EmailValidator.validate(value)) {
                  return 'Email no valido';
                }
              }
              return null;
            },
        controller: _getController(titulo),
        style: const TextStyle(color: Colors.white),
        obscureText: contrasena,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
               fontSize: 20,
               color: Colors.redAccent
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          fillColor: Colors.white,
        ),
      );
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
    if (_formKey.currentState!.validate()) {
      if(_contrasenaController.value.text==_repetircontrasenaController.value.text){
        AlumnoService().register(Alumno(_emailController.value.text,contrasena:_contrasenaController.value.text,nombre:_nombreController.value.text,apellidos:_apellidosController.value.text,fechanacimiento: currentDate,idCiclo: _cicloCursadoValue, localidad: _localidadController.value.text,idprovincias: _provinciavalue, calificacionMedia: double.parse( _calificacionController.value.text), foto: "TODO"))
        .then((value) =>{
          if (value) {
          Navigator.pushNamedAndRemoveUntil(context, "/",(Route<dynamic> route)=> false),
            
          } else {
            ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("Ya esta creada esa cuenta")))
          }
        },
        );
      }else{
        ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("No esta bien escrito las contraseña")));
      }
    }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF035860), Color(0xFF24476F)])),
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  int _getValue(String titulo) {
    switch (titulo) {
      case "Provincia":
        return _provinciavalue;
      case "Familia Profesional":
        return _familiaProfesionalValue;
      case "Tipo de grado":
        return _tipoGradoValue;
      case "Ciclo Cursado":
        return _cicloCursadoValue;
    }
    return -1;
  }

  void _setValue(String titulo, int value) {
    if (titulo == "Provincia") {
      _provinciavalue = value;
    } else if (titulo == "Familia Profesional") {
      _familiaProfesionalValue = value;
    } else if (titulo == "Tipo de grado") {
      _tipoGradoValue = value;
    } else if (titulo == "Ciclo Cursado") {
      _cicloCursadoValue = value;
    }
  }

  Future<dynamic> _getFutures(String titulo) {
    switch (titulo) {
      case "Provincia":
        return ProvinciasServices().getProvincias();
      case "Familia Profesional":
        return FamiliaProfeService().getFamiliaProfe(_tipoGradoValue);
      case "Tipo de grado":
        return TipoCicloService().getAllTipoCiclos();
      case "Ciclo Cursado":
        return CiclosService()
            .getCiclo(_tipoGradoValue, _familiaProfesionalValue);
    }
    throw Exception("error");
  }

  TextEditingController? _getController(String titulo) {
    switch (titulo) {
      case "Nombre":
        return _nombreController;
      case "Apellidos":
        return _apellidosController;
      case "Email":
        return _emailController;
      case "Contrasena":
        return _contrasenaController;
      case "Repetir Contrasena":
        return _repetircontrasenaController;
      case "Localidad":
        return _localidadController;
      case "Calificacion media del ciclo":
        return _calificacionController;
    }
  }
}
