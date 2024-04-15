import 'package:flutter/material.dart';

class HistoriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evolución de la Defensa Civil de RD'),
        backgroundColor: Colors.orange[900], // Color característico de la Defensa Civil
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHistoriaCard(
              context,
              'Antes del año 1966, cuando llegaba la temporada de huracanes, un grupo de radioaficionados se reunía en la Cruz Roja para estar atentos por si surgía algún tipo de emergencia, inmediatamente ponerse a disposición y ayudar en todo lo posible, inclusive, usando sus propios equipos de comunicación para así tener contacto con el exterior en caso de que las redes telefónicas resultaran afectadas.',
            ),
            SizedBox(height: 16.0),
            _buildHistoriaCard(
              context,
              'Al surgir el triunvirato fue designado el Dr. Rafael Cantizano Arias, como presidente de la Cruz Roja y al mismo tiempo nombraron al Ing. Carlos D´ Franco como director de la Defensa Civil, quien con un grupo compuesto por seis personas, se instaló en la calle Francia esquina Galván, siendo esa la primera oficina de la Defensa Civil.',
            ),
            SizedBox(height: 16.0),
            _buildHistoriaCard(
              context,
              'Al surgir el Gobierno Provisional, presidido por el Dr. Héctor García Godoy, a los diecisiete días del mes de junio de 1966, fue promulgada la Ley 257, mediante la cual fue creada la Defensa Civil, institución dependiente de la Secretaría Administrativa de la Presidencia (ahora Ministerio de la Presidencia) y quien en la actualidad preside la Comisión Nacional de Emergencias.',
            ),
            SizedBox(height: 16.0),
            _buildHistoriaCard(
              context,
              'Más adelante, el local fue trasladado a la calle Dr. Delgado No. 164 y luego en la gestión del Contralmirante Radhamés Lora Salcedo se reubicó a la Plaza de la Salud, donde aún permanece.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoriaCard(BuildContext context, String text) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
