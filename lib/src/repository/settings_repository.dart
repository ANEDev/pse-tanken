import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';
import 'package:tanken/src/repository/settings_database.dart';

abstract class SettingsRepository {
  SettingsRepository._();

  void saveFuelType(FuelType type);

  void saveSearchRadius(int radius);

  Future<FuelType> getFuelType();

  Future<int> getSearchRadius();
}

class SettingsRepositoryImpl implements SettingsRepository {
  Database _database;

  static const String FUEL_TYPE_STORE_NAME = 'FuelType';
  static const String SEARCH_RADIUS_STORE_NAME = 'SearchRadius';
  static const String LIST_SORT_ORDER_STORE_NAME = 'SearchRadius';

  SettingsRepositoryImpl();

  void initDB() async {
    final documentDIR = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDIR.path, 'settings.db');
    _database = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  void saveFuelType(FuelType type) async {
    if (_database == null) {
      await initDB();
    }
    Map<String, dynamic> map = {
      'fuelName': type.fuelName,
      'apiName': type.apiName
    };
    print('map: ${map}');
    await _database.put(map, FUEL_TYPE_STORE_NAME);
  }

  @override
  void saveSearchRadius(int radius) async {
    if (_database == null) {
      await initDB();
    }
    print('radius: ${radius}');
    await _database.put(radius, SEARCH_RADIUS_STORE_NAME);
  }

  @override
  void saveListSortOrder(SortOption sortOption) async {
    if (_database == null) {
      await initDB();
    }
    Map<String, dynamic> map = {
      'sortName': sortOption.sortName,
      'sortApiName': sortOption.sortApiName
    };
    print(map);
    await _database.put(map, LIST_SORT_ORDER_STORE_NAME);
  }

  @override
  Future<FuelType> getFuelType() async {
    if (_database == null) {
      await initDB();
    }
    try {
      Map<String, dynamic> fuelTypeMap = await _database.get(FUEL_TYPE_STORE_NAME);
      return fuelTypeFromMap(fuelTypeMap);
    } catch (error) {
    throw Exception(error.toString());
    }
  }

  @override
  Future<int> getSearchRadius() async {
    if (_database == null) {
      await initDB();
    }
    try {
      return await _database.get(SEARCH_RADIUS_STORE_NAME);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<SortOption> getListSortOrder() async {
    if (_database == null) {
      await initDB();
    }
    try {
      Map<String, dynamic> sortOrderMap = await _database.get(LIST_SORT_ORDER_STORE_NAME);
      return sortOptionFromMap(sortOrderMap);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
