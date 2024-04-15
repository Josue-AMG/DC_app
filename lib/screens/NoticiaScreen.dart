import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
 // Your code
 

  runApp( NoticiasScreen());
}

class NoticiasScreen extends StatefulWidget {
  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}


class _NoticiasScreenState extends State<NoticiasScreen> {
  
  late DcService serviceData = DcService(exito: false , datos: [], mensaje: '');

  @override
  void initState() { 
    super.initState();
    fetchData();
  }
  
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/noticias.php'));
      if (response.statusCode == 200) {
        setState(() {
          
          final data = json.decode(response.body);
          serviceData = DcService(
          exito: data['exito'],
          datos: (data['datos'] as List<dynamic>)
          .map((item) => Datos(
                titulo: item['titulo'],
                fecha: item['fecha'],
                contenido:  item['contenido'],
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
      // Puedes personalizar el color de fondo del appbar aquí
      backgroundColor: Colors.amber[900],
      title: Text('Noticias'), // Título de la pantalla
    ),
    body: Center(
      child: serviceData.datos!.isEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: serviceData.datos!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  // Puedes personalizar el estilo del contenedor Card aquí
                  child: ListTile(
                    
                    title: Column(children: [
                      Image.network(serviceData.datos![index].foto),
                      Divider(),
                      Text( 
                      serviceData.datos![index].titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // Puedes personalizar el estilo del texto aquí
                      ),
                    ),
                      Divider(),

                    ],),
                    subtitle: Text( 
                      serviceData.datos![index].contenido,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // Puedes personalizar el estilo del texto aquí
                      ),
                    ),
                  ),
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
    String titulo;
    String fecha;
    String contenido;
    String foto;

    Datos({
       required this.titulo,
       required this.fecha,
       required this.contenido,
       required this.foto
    });

}
