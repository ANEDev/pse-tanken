import 'package:meta/meta.dart';

abstract class FuelType {
  final String fuelName;
  final String apiName;

  FuelType(this.fuelName, this.apiName);
}

//TODO all fuel type

@immutable
class Diesel extends FuelType {
  Diesel() : super("Diesel", "diesel");
}

@immutable
class SuperE10 extends FuelType {
  SuperE10() : super("Super E10", "e10");
}

@immutable
class SuperE5 extends FuelType {
  SuperE5() : super("Super", "e5");
}

List<String> allFuelTypes() {
  List<FuelType> allFuelTypes = [Diesel(), SuperE5(), SuperE10()];

  List<String> res = List();

  allFuelTypes.forEach((fuelType) => res.add(fuelType.fuelName));
  return res;
}

FuelType fuelTypeForString(String fuelType) {
  if (fuelType == Diesel().fuelName) {
    return Diesel();
  }
  if (fuelType == SuperE10().fuelName) {
    return SuperE10();
  }
  if (fuelType == SuperE5().fuelName) {
    return SuperE5();
  }
  throw Exception("Fueltype not Available"); // TODO make this nicer somehow
}


FuelType fuelTypeFromMap(Map<String, dynamic> map) {
  switch (map['fuelName']) {
    case 'Diesel' : return Diesel();
    case 'Super E10' : return SuperE10();
    case 'Super' : return SuperE5();
  }
}