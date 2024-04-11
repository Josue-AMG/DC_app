import 'package:flutter/material.dart';
import 'package:dc_app/services/AlbergueService.dart';

class AlberguesComponent extends StatefulWidget {
  @override
  _AlberguesComponentState createState() => _AlberguesComponentState();
}

class _AlberguesComponentState extends State<AlberguesComponent> {
  List<CentroDeVacunacion>? _albergues;

  @override
  void initState() {
    super.initState();
    _cargarAlbergues();
  }

  Future<void> _cargarAlbergues() async {
    final albergues = await CentroVacunacionService().getCentrosDeVacunacion();
    setState(() {
      _albergues = albergues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albergues'),
        backgroundColor: const Color.fromARGB(255, 90, 93, 92),
      ),
      body: _albergues == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _albergues!.length,
              itemBuilder: (context, index) {
                final albergue = _albergues![index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: ListTile(
                    title: Text(
                      albergue.edificio,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ciudad: ${albergue.ciudad}'),
                        Text('Coordinador: ${albergue.coordinador}'),
                        Text('Teléfono: ${albergue.telefono}'),
                        Text('Capacidad: ${albergue.capacidad}'),
                      ],
                    ),
                    trailing: Icon(
                      Icons.houseboat_sharp,
                      color: Color.fromARGB(255, 214, 40, 34),
                    ),
                  ),
                );
              },
            ),
    );
  }
}