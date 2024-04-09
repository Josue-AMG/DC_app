
import 'package:flutter/material.dart';
class AlberguesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presentación'), // Título de la pantalla
      ),
      body: Center(
        child:Text("albergue"), // Mostramos el componente de presentación
      ),
    );
  }
}
