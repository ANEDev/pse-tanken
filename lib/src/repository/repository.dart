import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';
import 'package:tanken/src/models/petrolstation.dart';
import 'package:tanken/src/models/price.dart';
import 'package:tanken/src/models/webservice_result.dart';
import 'package:tanken/src/repository/web_service.dart';

abstract class Repository {
  Repository._();

  Future<List<PetrolStation>> getPetrolStationsInRange(
    double latitude,
    double longitude, {
    int rad,
    FuelType type,
    SortOption sort,
  });

  Future<List<PricesForStation>> getPricesForPetrolStations(
      List<PetrolStation> stations);

  Future<PetrolStation> getDetailsForPetrolStation(PetrolStation station);
}

class RepositoryImpl implements Repository {
  @override
  Future<PetrolStation> getDetailsForPetrolStation(PetrolStation station) {
    // TODO: implement getDetailsForPetrolStation
    return null;
  }

  @override
  Future<List<PetrolStation>> getPetrolStationsInRange(
    double latitude,
    double longitude, {
    int rad = 5,
    FuelType type,
    SortOption sort,
  }) async {
    print('Repository radius: ${rad}');
    WebServiceImpl webService = WebServiceImpl();
    WebServiceResult webServiceResult =
        await webService.getPetrolStationsInRange(
      latitude,
      longitude,
      rad: rad == null ? 5 : rad,
      type: type == null ? "all" : type.apiName,
      sort: sort == null ? SortPrice().sortApiName : sort.sortApiName,
    );

    if (webServiceResult.status == 200) {
      return webServiceResult.data;
    } else {
      throw Exception('${webServiceResult.status} ${webServiceResult.data}');
    }
  }

  @override
  Future<List<PricesForStation>> getPricesForPetrolStations(
      List<PetrolStation> stations) async {
    WebServiceImpl webService = WebServiceImpl();
    WebServiceResult webServiceResult =
        await webService.getPricesForPetrolStations(stations);

    if (webServiceResult.status == 200) {
      return webServiceResult.data;
    } else {
      throw Exception('${webServiceResult.status} ${webServiceResult.data}');
    }
  }
}
