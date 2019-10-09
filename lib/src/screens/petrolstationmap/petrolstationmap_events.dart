import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';

abstract class MapEvent {}

class FetchMapEvent extends MapEvent {
  final SortOption sortOption;
  final FuelType fuelType;
  final int radius;

  FetchMapEvent({
    SortOption sortOption,
    FuelType fuelType,
    int radius
  })  : this.fuelType = fuelType == null ? Diesel() : fuelType,
        this.sortOption = sortOption == null ? SortPrice() : sortOption,
        this.radius = radius;
}
