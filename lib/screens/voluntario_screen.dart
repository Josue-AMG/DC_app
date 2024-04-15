import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class VoluntarioScreen extends StatefulWidget {
  const VoluntarioScreen({Key? key});

  @override
  State<VoluntarioScreen> createState() => _VoluntarioScreen();
}

class _VoluntarioScreen extends State<VoluntarioScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _cedula = '';
  String _nombre = '';
  String _apellidos = '';
  String _clave = '';
  String _correo = '';
  String _telefono = '';
  
  bool _autoValidate = false; // Variable para controlar la visibilidad de las validaciones
  
  Future<void> sendData() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Definir los datos a enviar
        Map<String, dynamic> requestBody = {
          'Cedula': _cedula,
          'Nombre': _nombre,
          'Apellidos': _apellidos,
          'Clave': _clave,
          'Correo': _correo,
          'Telefono': _telefono,
        };

        // Realizar la petición POST
        final response = await http.post(
          Uri.parse('https://adamix.net/defensa_civil/def/registro.php'),
          body: json.encode(requestBody),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          // Mostrar un mensaje de éxito al guardar la información
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Información enviada con éxito')),
          );
          print('Datos enviados correctamente');
        } else {
          throw Exception('Error al enviar los datos: ${response.statusCode}');
        }
      } else {
        // Cambiar el estado de la validación para mostrar los errores
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],// Color de fondo del appbar
        title: const Text('Nuevo Voluntario'), // Título de la pantalla
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20), // Espaciado interno del contenedor
          width: 600,
          height: 800,
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Espacio entre el appbar y el contenido
                const Text(
                  "Nuevo Voluntario",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30, // Tamaño de fuente del título
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(), // Línea divisoria
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Cedula', // Texto de ejemplo dentro del campo
                    border: OutlineInputBorder(), // Bordes del campo de texto
                  ),
                  keyboardType: TextInputType.number, // Teclado numérico
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Permitir solo dígitos
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo cedula es requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cedula = value!;
                  },
                  onChanged: (_) {
                    setState(() {
                      _autoValidate = false;
                    });
                  },
                ),
                const SizedBox(height: 10), // Espacio entre campos de texto
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo nombre es requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nombre = value!;
                  },
                  onChanged: (_) {
                    setState(() {
                      _autoValidate = false;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo apellidos es requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _apellidos = value!;
                  },
                  onChanged: (_) {
                    setState(() {
                      _autoValidate = false;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Clave',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo clave es requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _clave = value!;
                  },
                  onChanged: (_) {
                    setState(() {
                      _autoValidate = false;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo correo es requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _correo = value!;
                  },
                  onChanged: (_) {
                    setState(() {
                      _autoValidate = false;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Telefono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone, // Teclado numérico con símbolo de teléfono
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Permitir solo dígitos
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo telefono es requerido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _telefono = value!;
                  },
                  onChanged: (_) {
                    setState(() {
                      _autoValidate = false;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Guardar los datos del formulario
                    _formKey.currentState!.save();
                    // Enviar los datos si el formulario es válido
                    await sendData();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
