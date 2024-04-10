import 'package:dc_app/models/voluntario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const VoluntarioScreen());
}

class VoluntarioScreen extends StatelessWidget {
  const VoluntarioScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                      width: 600,
                          height: 800,
                          child: Column(
                            children: [
                              AlertDialog(
                                  content: Column(children: [
                                const Text("Nuevo Voluntario",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 45)),
                                const Divider(),
                                TextField(
                                  decoration:
                                      const InputDecoration(hintText: 'Cedula'),
                                ),
                                TextField(
                                  decoration:
                                      const InputDecoration(hintText: 'Nombre'),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                      hintText: 'Apellidos'),
                                ),
                                TextField(
                                  decoration:
                                      const InputDecoration(hintText: 'Clave'),
                                ),
                                TextField(
                                  decoration:
                                      const InputDecoration(hintText: 'Correo'),
                                ),
                                TextField(
                                  decoration:
                                      const InputDecoration(hintText: 'Telefono'),
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                ),
                                ButtonBar(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {},
                                        child: const Text('Guardar')),
                              
                                  ],
                                ),
                              ])),
                            ],
                          ),
                        ),
            )
            
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}