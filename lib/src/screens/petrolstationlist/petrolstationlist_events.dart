import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';

abstract class PetrolEvent {}

class FetchPetrolEvent extends PetrolEvent {
  final SortOption sortOption;
  final FuelType fuelType;
  final int radius;

  FetchPetrolEvent({
    SortOption sortOption,
    FuelType fuelType,
    int radius,
  })  : this.fuelType = fuelType == null ? Diesel() : fuelType,
        this.sortOption = sortOption == null ? SortPrice() : sortOption,
        this.radius = radius;
}
