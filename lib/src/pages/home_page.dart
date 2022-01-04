import 'package:ciclojobs/src/pages/profile_page.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _currentIndex =0 ;
    final screens=[
      ProfilePage(),
    ];
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: screens[0],
        
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
        type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap:(index){
            setState(() {
              _currentIndex=index;
            });
          },
          items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
            backgroundColor: Colors.blueAccent),
             BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: "hola",
            backgroundColor: Colors.red),
             BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
            backgroundColor: Colors.green)
          ],
        ),
        
        
        ),
      );
  }
}