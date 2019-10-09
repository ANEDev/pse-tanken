import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:tanken/src/models/petrolstation.dart';
import 'package:tanken/src/models/price.dart';
import 'package:tanken/src/models/webservice_result.dart';

abstract class WebService {
  WebService._();
}

class WebServiceImpl implements WebService {
  static const API_KEY = "2b421a4a-5ecc-c88e-026d-f97fe5ce65ce"; // TODO EXTRACT
  static const BASE_URL = "creativecommons.tankerkoenig.de";
  static const LIST_ROUTE = "/json/list.php";
  static const PRICE_ROUTE = "/json/prices.php";

  Future<WebServiceResult> getPricesForPetrolStations(
      List<PetrolStation> stations) async {
    String listOfIds = stations[0].id;
    for (int i = 1; i < stations.length; i++) {
      listOfIds += ',' + stations[i].id;
    }
    Map<String, String> queryParameters = {
      'ids': listOfIds,
      'apikey': API_KEY,
    };
    Uri url = Uri.https(BASE_URL, PRICE_ROUTE, queryParameters);
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var map = parsedJson['prices'] as Map<String, dynamic>;
      List<PricesForStation> pricesForStations = List<PricesForStation>();
      map.forEach((id, value) {
        Price price = Price.fromJson(value);
        pricesForStations.add(PricesForStation(id: id, prices: price));
      });
      return WebServiceResult(response.statusCode, pricesForStations);
    } else {
      return WebServiceResult(response.statusCode, response.reasonPhrase);
    }
  }

  Future<WebServiceResult> getPetrolStationsInRange(
    double latitude,
    double longitude, {
    int rad = 5,
    String type = "all",
    String sort = "dist",
  }) async {
    Map<String, String> queryParameters = {
      'lat': latitude.toString(),
      'lng': longitude.toString(),
      'rad': rad.toString(),
      'type': type,
      'sort': sort,
      'apikey': API_KEY,
    };

    // TODO REPLACE ENUM
    // TODO TECHNICAL DEPTH HARD CODED VARS

    Uri url = Uri.https(BASE_URL, LIST_ROUTE, queryParameters);
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var list = parsedJson['stations'] as List;
      List<PetrolStation> petrolStationList =
          list.map((i) => PetrolStation.fromJson(i)).toList();
      return WebServiceResult(response.statusCode, petrolStationList);
    } else {
      return WebServiceResult(response.statusCode, response.reasonPhrase);
    }
  }
}
