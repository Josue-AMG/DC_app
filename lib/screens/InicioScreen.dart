import 'package:dc_app/components/HomeComponent.dart';
import 'package:flutter/material.dart';
class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presentación'), 
      ),
      body: Center(
        child:HomeComponent() , 
      ),
    );
  }
}
