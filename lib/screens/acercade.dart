import 'package:flutter/material.dart';

class AcercadeScreen extends StatelessWidget {
  const AcercadeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text("Estos son los colaboradores que influyeron en este proyecto con infomacion de la DC (Defensa Civil):",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),),
            Divider(),
            _alumnoTile(
              nombre: 'Jayson Ventura',
              matricula: '2022-0062',
              imagen: 'images/jayson.jpg',
            ),
            _alumnoTile(
              nombre: 'Josue Moreno',
              matricula: '2019-8623',
              imagen: 'images/josue.jpg',
            ),
            _alumnoTile(
              nombre: 'Marianny Montero',
              matricula: '2019-8173',
              imagen: 'images/marianny.jpg',
            ),
            _alumnoTile(
              nombre: 'Morphy De Oleo',
              matricula: '2020-9904',
              imagen: 'images/morphy.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _alumnoTile({
    required String nombre,
    required String matricula,
    required String imagen,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagen),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Row(children: [
            Text(
              'Matrícula: ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
            ),
                        Text(
              '${matricula}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),

            ],)

          ],
        ),
      ),
    );
  }
}
