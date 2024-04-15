
import 'package:dc_app/components/AlberguesListComponent.dart';
import 'package:flutter/material.dart';
class AlberguesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:AlberguesComponent(), // Mostramos el componente de presentación
      ),
    );
  }
}
