import 'package:dc_app/screens/AlberguesScreen.dart';
import 'package:dc_app/screens/HistoriaScreen.dart';
import 'package:dc_app/screens/MedidaPreventivaScreen.dart';
import 'package:dc_app/screens/Miembro.dart';
import 'package:dc_app/screens/ServiciosScreen.dart';
import 'package:dc_app/screens/VideroScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // Importa la biblioteca de iconos

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Sidebar Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.foot_print), // Icono con letras para "Inicio"
            title: Text('Historia'),
            onTap: () {
              Navigator.pop(context); // Cierra el sidebar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoriaScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.newspaper), // Icono para "Noticias"
            title: Text('Servicios'),
            onTap: () {
              Navigator.pop(context); // Cierra el sidebar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiciosScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.video_outline), // Icono para "Videos"
            title: Text('Videos'),
            onTap: () {
              Navigator.pop(context); // Cierra el sidebar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.greenhouse), // Icono con letras para "Albergues"
            title: Text('Albergues'),
            onTap: () {
              Navigator.pop(context); // Cierra el sidebar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlberguesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.shield_home_outline), // Icono para "Medida Preventiva"
            title: Text('Medida Preventiva'),
            onTap: () {
              Navigator.pop(context); // Cierra el sidebar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedidaPreventivaScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(MaterialCommunityIcons.account_outline), // Icono para "Miembros"
            title: Text('Miembros'),
            onTap: () {
              Navigator.pop(context); // Cierra el sidebar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MiembroScreen()),
              );
            },
          ),
          // Puedes agregar más ListTile para más opciones si es necesario
        ],
      ),
    );
  }
}
