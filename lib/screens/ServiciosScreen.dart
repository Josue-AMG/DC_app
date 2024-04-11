import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';





void main() {
 // Your code
 

  runApp( ServiciosScreen());
}

class ServiciosScreen extends StatefulWidget {
  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}


class _ServiciosScreenState extends State<ServiciosScreen> {
  
  late DcService serviceData = DcService(exito: false , datos: [], mensaje: '');
  
  

  

  @override
  void initState() { 
    super.initState();
    fetchData();
  }
  
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/servicios.php'));
      if (response.statusCode == 200) {
        setState(() {
          
          final data = json.decode(response.body);
          serviceData = DcService(
          exito: data['exito'],
          datos: (data['datos'] as List<dynamic>)
          .map((item) => Datos(
                id: item['id'],
                nombre: item['nombre'],
                descripcion: item['descripcion'],
                foto: item['foto'],
              ))
          .toList(),
      mensaje: data['mensaje'],
    );
        });
      } else {
        throw Exception('Error al cargar los servicios');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text('Servicios'), // Título de la pantalla
      ),
      body: Center(
        child: serviceData.datos!.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: serviceData.datos!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Container(color:Colors.blue[900],child:Text(serviceData.datos![index].nombre,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                    subtitle: Container(color:Colors.amber[900],child:Text(serviceData.datos![index].descripcion,style: TextStyle(fontWeight: FontWeight.bold),)),
                  );
                },
              ),
      ),
    );
  }
}

class DcService {
    bool? exito;
    List<Datos>? datos;
    String? mensaje;

    DcService({
      required this.exito,
      required this.datos,
      required this.mensaje,
    });

}

class Datos {
    String id;
    String nombre;
    String descripcion;
    String foto;

    Datos({
       required this.id,
       required this.nombre,
       required this.descripcion,
       required this.foto,
    });

}