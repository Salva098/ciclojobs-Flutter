import 'package:ciclojobs/src/pages/login_page.dart';
import 'package:ciclojobs/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CicloJobsApp());
}

class CicloJobsApp extends StatelessWidget {
  const CicloJobsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'CicloJobs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.dosisTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.dosis(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: GetApplicationRoute(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      },
    );
  }
}
