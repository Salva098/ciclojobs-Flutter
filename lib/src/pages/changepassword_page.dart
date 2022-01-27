import 'package:ciclojobs/src/services/alumno_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  int _index = 0;
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _codeController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
  final TextEditingController _confirmPasswordController= TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cambiar Contraseña"),
      ),
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index = 0;
            });
          }
        },
        onStepContinue: () {
          if (_index >= 0 && _index <= 2) {
            switch (_index) {
              case 0:
                if(_formKey.currentState!.validate()){
                  AlumnoService().enviarEmail(_emailController.text).then((value) => {
                    if(value){

                setState(() {
                      _index = 1;
                    })
                    }else{
                      ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("No existe un alumno con ese correo")))
                    }
                  });
                }
                break;
                case 1:
                if(_formKey2.currentState!.validate()){
                  AlumnoService().checkCode(_emailController.text,_codeController.text).then((value) => {
                    if(value){

                setState(() {
                      _index = 2;

                    })
                    }else{
                      ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("Codigo invalido")))
                    }
                  });
                }
                break;
                case 2:
                if(_formKey3.currentState!.validate()){
                  if(_passwordController.text==_confirmPasswordController.text){

                  AlumnoService().changepassword(_emailController.text, _passwordController.text).then((value) => {
                    if(value){

                setState(() {
                      Navigator.pop(context);

                    })
                    }else{
                      ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("Error")))
                    }
                  }
                  );
                  }else{
                    ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("No son la misma contraseña")));
                  }
                }else{
                  ScaffoldMessenger.of (context)
          .showSnackBar(const SnackBar(content: Text("Rellena los campos")));
                }
                break;
              
            }
            print(_index);
            
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
      
        steps: <Step>[
          Step(
            state: _index>1 ? StepState.disabled : StepState.editing,
            isActive: _index>=0,
            title: const Text('Email de la cuenta'),
            content: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                         validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                             if (!EmailValidator.validate(value)) {
                                return 'Email no valido';
                              }
                              return null;
                            },
                         controller: _emailController  
                    
                      ),
                    ),
                  ],
                )),
          ),
          Step(
            isActive: _index>=1,
            state: _index>1 ? StepState.disabled : StepState.editing,

            title: const Text('Codigo de verificacion'),
            content: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey2,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                         validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                              return null;
                            },
                         controller: _codeController  
                    
                      ),
                    ),
                  ],
                )),
          ),
          Step(
            isActive: _index==2,
            state: _index>=3 ? StepState.editing  :StepState.disabled,

            title: const Text('Cambiar Contraseña'),
            content: Container(
                alignment: Alignment.centerLeft,
                child:  Column(
                  children: [
                    Form(
                      key: _formKey3,
                      child: Column(
                        children:[
                          TextFormField(
                          decoration: const InputDecoration(
                                  hintText: "Contraseña"
                                    ),
                         obscureText: true,

                           validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                                return null;
                              },
                           controller: _passwordController  
                                          
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                                  hintText: " Confirma Contraseña"
                                    ),
                         obscureText: true,
                           validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                                return null;
                              },
                           controller: _confirmPasswordController  
                                          
                        )
                        ]
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
 
}
