import 'package:dc_app/models/voluntario.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  static IsarHelper? isarHelper;
  IsarHelper._internal();

  static IsarHelper get instance => isarHelper ??= IsarHelper._internal();

  static Isar? _isarDb;

  Isar get isar => _isarDb!;

  Future<void> init() async {
    if(_isarDb == null){
      return;
    }
    final path = (await getApplicationCacheDirectory()).path;
    _isarDb = await Isar.open([VoluntarioSchema],directory: path);
  }
}