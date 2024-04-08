import 'package:dc_app/screens/MapaScreen.dart';
import 'package:dc_app/screens/NoticiaScreen.dart';
import 'package:dc_app/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:dc_app/screens/InicioScreen.dart';
import 'package:dc_app/components/Sidebar.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(
              imagePath: 'assets/splash.gif',
              duration: Duration(seconds: 4),
            ),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    InicioScreen(),
    NoticiasScreen(),
    MapaScreen()
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _screens[_selectedIndex],
      drawer: Sidebar(), // Agrega el sidebar aquí
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapas',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
