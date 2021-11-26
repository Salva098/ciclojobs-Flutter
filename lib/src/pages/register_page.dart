import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime currentDate = DateTime.now();
  String _provinciavalue = 'hola';
  String _familiaProfesionalValue = 'hola';
  String _tipoGradoValue = 'hola';
  String _cicloCursadoValue = 'hola';

  List<String> lista = ['hola', 'wuenas', 'tardes'];

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
    return Column(
      children: [
        _entryField("Name"),
        _entryField("surnames"),
        _entryField("Email"),
        _entryField("Password", contrasena: true),
        _entryField("Repeat password", contrasena: true),
        _datepikerbutton(),
        _dropDown('Provincia'),
        _dropDown('Familia Profesional'),
        _entryField('Localidad'),
        _dropDown('Tipo de grado'),
        _dropDown('Ciclo Cursado'),
        _entryField('Calificaacion media del ciclo',decial: true)
      ],
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
            data: Theme.of(context).copyWith(canvasColor: Colors.blue[500]),
            child: DropdownButtonFormField(
              style: const TextStyle(
                // color: Colors.,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              value: _getValue(titulo),
              items: lista
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _setValue(titulo,value as String);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  // List<DropdownMenuItem> _getListaitems() {

  //   return ;
  //   }

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
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          _textField(contrasena, decial)  
        ],
      ),
    );
  }

  TextField _textField(bool contrasena, bool decimal) {
    if (decimal) {
      return TextField(
        style: const TextStyle(color: Colors.white),
        obscureText: contrasena,
        decoration: InputDecoration(
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
      return TextField(
        style: const TextStyle(color: Colors.white),
        obscureText: contrasena,
        decoration: InputDecoration(
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
          fillColor:  Colors.white,
        ),
      );
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "login");
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

  String _getValue(String titulo) {
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
    return "ERROR";
  }
  void _setValue(String titulo,String value) {
    if (titulo=="Provincia") {
      _provinciavalue =value;
    } else if (titulo=="Familia Profesional") {
      _familiaProfesionalValue=value;
    }else if (titulo=="Tipo de grado") {
      _tipoGradoValue=value;
    } else if (titulo=="Ciclo Cursado") {
      _cicloCursadoValue=value;
    } 
  }
}
