import 'package:isar/isar.dart';

part 'voluntario.g.dart';

@collection
class Voluntario{
    Id id = Isar.autoIncrement;
    String cedula = "";
    String nombre = "";
    String apellido = "";
    String clave = "";
    String correo = ""; 
    String telefono = ""; 
}