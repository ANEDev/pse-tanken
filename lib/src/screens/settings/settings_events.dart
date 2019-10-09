import 'package:meta/meta.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';

abstract class SettingsEvent {}

@immutable
class FuelChangedEvent extends SettingsEvent {
  final FuelType fuelType;

  FuelChangedEvent(this.fuelType);
}

@immutable
class ListSortOrderChangedEvent extends SettingsEvent {
  final SortOption sortOption;

  ListSortOrderChangedEvent(this.sortOption);
}

@immutable
class SearchRadiusChangedEvent extends SettingsEvent {
  final int searchRadius;

  SearchRadiusChangedEvent(this.searchRadius);
}

@immutable
class SettingsLoaded extends SettingsEvent {
  final FuelType fuelType;
  final SortOption sortOption;
  final int searchRadius;

  SettingsLoaded(this.fuelType, this.sortOption, this.searchRadius);
}

