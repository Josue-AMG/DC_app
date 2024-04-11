import 'dart:convert';
import 'package:http/http.dart' as http;

class CentroVacunacionService {
  Future<List<CentroDeVacunacion>> getCentrosDeVacunacion() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> datos = data['datos'];
      return datos.map((json) => CentroDeVacunacion.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}




class CentroDeVacunacion {
  final String ciudad;
  final String codigo;
  final String edificio;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final double lat;
  final double lng;

  CentroDeVacunacion({
    required this.ciudad,
    required this.codigo,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });

  factory CentroDeVacunacion.fromJson(Map<String, dynamic> json) {
    return CentroDeVacunacion(
      ciudad: json['ciudad'],
      codigo: json['codigo'],
      edificio: json['edificio'],
      coordinador: json['coordinador'],
      telefono: json['telefono'],
      capacidad: json['capacidad'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
    );
  }
}
