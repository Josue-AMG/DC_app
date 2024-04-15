import 'package:flutter/material.dart';
import 'package:dc_app/services/AlbergueService.dart';

class AlberguesComponentMap extends StatefulWidget {
  @override
  _AlberguesComponentMapState createState() => _AlberguesComponentMapState();
}

class _AlberguesComponentMapState extends State<AlberguesComponentMap> {
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
        backgroundColor: Colors.orange[900],
      ),
      body: _albergues == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: _albergues!.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final albergue = _albergues![index];
                return ListTile(
                  title: Text(
                    albergue.edificio,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                    Icons.directions,
                    color: Colors.orange[900] ,
                  ),
                  onTap: () {
                    Navigator.of(context).pop(albergue);
                  },
                );
              },
            ),
    );
  }
}
