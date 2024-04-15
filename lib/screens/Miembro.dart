import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MiembroScreen(),
    );
  }
}

class MiembroScreen extends StatefulWidget {
  @override
  State<MiembroScreen> createState() => _MiembroScreenState();
}

class _MiembroScreenState extends State<MiembroScreen> {
  late MiembrosService miembrosService = MiembrosService(
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
      final response = await http
          .get(Uri.parse('https://adamix.net/defensa_civil/def/miembros.php'));
      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          miembrosService = MiembrosService(
            exito: data['exito'],
            datos: (data['datos'] as List<dynamic>)
                .map((item) => Miembro(
                      id: item['id'],
                      nombre: item['nombre'],
                      cargo: item['cargo'],
                      fotoUrl: item['foto'], // Agregamos la URL de la foto
                    ))
                .toList(),
            mensaje: data['mensaje'],
          );
        });
      } else {
        throw Exception('Error al cargar los miembros');
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
        title: Text('Miembros'),
      ),
      body: Center(
        child: miembrosService.datos.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: miembrosService.datos.length,
                itemBuilder: (BuildContext context, int index) {
                  final miembro = miembrosService.datos[index];
                  return MiembroCard(miembro: miembro);
                },
              ),
      ),
    );
  }
}

class MiembroCard extends StatefulWidget {
  final Miembro miembro;

  const MiembroCard({Key? key, required this.miembro}) : super(key: key);

  @override
  _MiembroCardState createState() => _MiembroCardState();
}

class _MiembroCardState extends State<MiembroCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _isExpanded ? Colors.grey[200] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.miembro.fotoUrl),
              radius: _isExpanded ? 100.0 : 50.0,
            ),
            SizedBox(height: 16.0),
            Text(
              widget.miembro.nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _isExpanded ? 24.0 : 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.miembro.cargo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _isExpanded ? 20.0 : 14.0,
                color: Colors.grey[700],
              ),
            ),
            if (_isExpanded) SizedBox(height: 16.0),
            if (_isExpanded)
              Text(
                'ID: ${widget.miembro.id}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MiembrosService {
  bool? exito;
  List<Miembro> datos;
  String? mensaje;

  MiembrosService({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });
}

class Miembro {
  String id;
  String nombre;
  String cargo;
  String fotoUrl;

  Miembro({
    required this.id,
    required this.nombre,
    required this.cargo,
    required this.fotoUrl,
  });
}