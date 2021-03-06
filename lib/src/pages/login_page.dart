import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeycode = GlobalKey<FormState>();
  String token="";
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
                      _emailPasswordWidget(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'changepassword');
                          },
                          child: const Text('Forgot Password ?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _submitButton(),
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

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _entryField("Email"),
          _entryField("Password", contrasena: true)
        ],
      ),
    );
  }

  Widget _entryField(String titulo, {bool contrasena = false}) {
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
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (titulo == "Email") {
                if (!EmailValidator.validate(value)) {
                  return 'Email no valido';
                }
              }
              return null;
            },
            controller: getController(titulo),
            obscureText: contrasena,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorStyle:
                  const TextStyle(fontSize: 20, color: Colors.redAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red),
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
          )
        ],
      ),
    );
  }

  _login() {
    if (_formKey.currentState!.validate()) {
      AlumnoService()
          .login(_userController.value.text, _passwordController.value.text)
          .then((value) => {
                if (value == "")
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Invalido")))
                  }
                else
                  {
                    token=value,
                    AlumnoService()
                        .checkAccount(_userController.text)
                        .then((data) => {
                              if (data)
                                {
                                  dotenv.env['ID_ALUMNO'] = value,
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      "home", (Route<dynamic> route) => false)
                                }
                              else
                                {
                                  AlumnoService().enviarEmail( _userController.text).then((enviado)=>{

                                  if (enviado) {
                                     showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Codigo de verificaci??n'),
                                          content: Form(
                                              key: _formKeycode,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Este campo es obligatorio';
                                                  }
                                                  return null;
                                                },
                                                controller: _codeController,
                                              )),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                if (_formKeycode.currentState!
                                                    .validate()) {
                                                  AlumnoService()
                                                      .checkCode(
                                                          _userController.text,
                                                          _codeController.text)
                                                      .then((value) => {
                                                            if (value)
                                                              {
                                                                dotenv.env['ID_ALUMNO'] = token,
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      "home", (Route<dynamic> route) => false)
                                                              }
                                                            else
                                                              {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text("Error")))
                                                              }
                                                          });
                                                }
                                              },
                                              child: const Text('ACCEPT'),
                                            ),
                                          ],
                                        );
                                      })
                                  } else {
                                    ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error al enviar el codigo")))
                                  }
                                 
                                      }


                                  )
                                }
                            })
                  }
              });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Invalido")));
    }
  }

  _submitButton() {
    return InkWell(
      onTap: () {
        _login();
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
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  TextEditingController? getController(String titulo) {
    switch (titulo) {
      case "Email":
        return _userController;
      case "Password":
        return _passwordController;
    }
  }
}
