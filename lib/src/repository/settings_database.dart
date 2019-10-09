import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:async';

class SettingsDatabase {
  SettingsDatabase._internal();

  static SettingsDatabase get instance => _singleton;

  static final SettingsDatabase _singleton = SettingsDatabase._internal();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  static Future initDB() async {
    final documentDIR = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDIR.path, 'settings.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}