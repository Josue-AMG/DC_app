import 'package:flutter/material.dart';
class NoticiasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'), 
      ),
      body: Center(
        child:Text("CNN") ,
      ),
    );
  }
}
