import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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
                contenido:  item['contenido']
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
        title: Text('Noticias'), // Título de la pantalla
      ),
      body: Center(
        child: serviceData.datos!.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: serviceData.datos!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Container(color:Colors.blue[900],child:Text('${serviceData.datos![index].titulo} ${serviceData.datos![index].fecha}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                    subtitle: Container(color:Colors.amber[900],child:Text(serviceData.datos![index].contenido,style: TextStyle(fontWeight: FontWeight.bold),)),
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

    Datos({
       required this.titulo,
       required this.fecha,
       required this.contenido
    });

}
