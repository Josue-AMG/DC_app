import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedidaPreventivaScreen(),
    );
  }
}

class MedidaPreventivaScreen extends StatefulWidget {
  @override
  State<MedidaPreventivaScreen> createState() => _MedidaPreventivaScreenState();
}

class _MedidaPreventivaScreenState extends State<MedidaPreventivaScreen> {
  late MedidasPreventivasService medidasPreventivasService =
      MedidasPreventivasService(
    exito: false,
    datos: [],
    mensaje: '',
  );

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://adamix.net/defensa_civil/def/medidas_preventivas.php'));
      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          medidasPreventivasService = MedidasPreventivasService(
            exito: data['exito'],
            datos: (data['datos'] as List<dynamic>)
                .map((item) => MedidaPreventiva.fromJson(item))
                .toList(),
            mensaje: data['mensaje'],
          );
        });
      } else {
        throw Exception('Error al cargar las medidas preventivas');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text('Medidas Preventivas'),
      ),
      body: Center(
        child: medidasPreventivasService.datos.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: medidasPreventivasService.datos.length,
                itemBuilder: (BuildContext context, int index) {
                  final medidaPreventiva =
                      medidasPreventivasService.datos[index];
                  return MedidaPreventivaCard(
                      medidaPreventiva: medidaPreventiva);
                },
              ),
      ),
    );
  }
}

class MedidaPreventivaCard extends StatelessWidget {
  final MedidaPreventiva medidaPreventiva;

  const MedidaPreventivaCard({Key? key, required this.medidaPreventiva})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                medidaPreventiva.fotoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medidaPreventiva.titulo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  medidaPreventiva.descripcion,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedidasPreventivasService {
  bool? exito;
  List<MedidaPreventiva> datos;
  String? mensaje;

  MedidasPreventivasService({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });
}

class MedidaPreventiva {
  String id;
  String titulo;
  String descripcion;
  String fotoUrl;

  MedidaPreventiva({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fotoUrl,
  });

  factory MedidaPreventiva.fromJson(Map<String, dynamic> json) {
    return MedidaPreventiva(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fotoUrl: json['foto'],
    );
  }
}