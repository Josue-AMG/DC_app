import 'package:dc_app/services/AlbergueService.dart';
import 'package:flutter/material.dart';

class pruebaComponent extends StatefulWidget {
  @override
  _pruebaComponentState createState() => _pruebaComponentState();
}

class _pruebaComponentState extends State<pruebaComponent> {
  List<CentroDeVacunacion> centrosDeVacunacion = [];
  final CentroVacunacionService _centroVacunacionService = CentroVacunacionService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final List<CentroDeVacunacion> data = await _centroVacunacionService.getCentrosDeVacunacion();
      setState(() {
        centrosDeVacunacion = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: centrosDeVacunacion.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(centrosDeVacunacion[index].ciudad),
                subtitle: Text(centrosDeVacunacion[index].edificio),
                onTap: () {
                  // Aquí puedes agregar cualquier acción que desees realizar al hacer clic en un elemento de la lista
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
