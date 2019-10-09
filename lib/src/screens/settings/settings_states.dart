import 'package:meta/meta.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';

abstract class SettingsState {
  final FuelType fuelType;
  final int searchRadius;
  final SortOption sortOption;

  SettingsState(this.fuelType, this.searchRadius, this.sortOption);
}

class DefaultSettings extends SettingsState {
  DefaultSettings() : super(Diesel(), 5, SortPrice());
}

@immutable
class CurrentSettings extends SettingsState {
  CurrentSettings(
    FuelType fuelType,
    int searchRadius,
    SortOption sortOption,
  ) : super(fuelType, searchRadius, sortOption);
}
