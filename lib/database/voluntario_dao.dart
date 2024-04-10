

import 'package:dc_app/database/isar_helper.dart';
import 'package:dc_app/models/voluntario.dart';
import 'package:isar/isar.dart';

class VoluntarioDao {
  final isar = IsarHelper.instance.isar;


  Future<List<Voluntario>> getall() async {
    return isar.voluntarios.where().findAll();
  }

  Future<bool> deleteOne(Voluntario evento) async {
    return isar.writeTxn(() => isar.voluntarios.delete(evento.id));
  }

  Future<int> deleteAll(List<int> ids) async {
    return isar.writeTxn(() => isar.voluntarios.deleteAll(ids));
  }

  Future<int> upsert(Voluntario evento) async {
    return isar.writeTxn(() => isar.voluntarios.put(evento));
  }

}