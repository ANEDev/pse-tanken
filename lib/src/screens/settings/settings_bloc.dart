import 'package:bloc/bloc.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';
import 'package:tanken/src/repository/settings_repository.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_bloc.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_bloc.dart';

import 'package:tanken/src/screens/settings/settings_events.dart';
import 'package:tanken/src/screens/settings/settings_states.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final PetrolBloc _petrolBloc;
  final MapBloc _mapBloc;

  SettingsBloc(this._petrolBloc, this._mapBloc);

  @override
  SettingsState get initialState => DefaultSettings();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is FuelChangedEvent) {
      SettingsRepositoryImpl settingsRepo = SettingsRepositoryImpl();
      settingsRepo.saveFuelType(event.fuelType);
      yield CurrentSettings(
        event.fuelType,
        currentState.searchRadius,
        currentState.sortOption,
      );
    }
    if (event is ListSortOrderChangedEvent) {
      SettingsRepositoryImpl settingsRepo = SettingsRepositoryImpl();
      settingsRepo.saveListSortOrder(event.sortOption);
      yield CurrentSettings(
        currentState.fuelType,
        currentState.searchRadius,
        event.sortOption,
      );
    }
    if(event is SearchRadiusChangedEvent){
      SettingsRepositoryImpl settingsRepo = SettingsRepositoryImpl();
      settingsRepo.saveSearchRadius(event.searchRadius);
      yield CurrentSettings(
        currentState.fuelType,
        event.searchRadius,
        currentState.sortOption,
      );
    }
    if(event is SettingsLoaded){
      SettingsRepositoryImpl settingsRepo = SettingsRepositoryImpl();
      settingsRepo.saveFuelType(event.fuelType);
      settingsRepo.saveListSortOrder(event.sortOption);
      settingsRepo.saveSearchRadius(event.searchRadius);
      yield CurrentSettings(
        event.fuelType,
        event.searchRadius,
        event.sortOption,
      );
    }

    _petrolBloc.onFetchPetrolStations(
      currentState.fuelType,
      currentState.sortOption,
      currentState.searchRadius,
    );
    _mapBloc.onFetchPetrolStations(
      currentState.fuelType,
      currentState.sortOption,
      currentState.searchRadius,
    );
  }

  void onFuelTypeChanged(FuelType fuelType) =>
      dispatch(FuelChangedEvent(fuelType));

  void onSortOrderChanged(SortOption sortOption) =>
      dispatch(ListSortOrderChangedEvent(sortOption));

  void onSearchRadiusChanged(int radius) =>
      dispatch(SearchRadiusChangedEvent(radius));

  void onSettingsLoaded(FuelType fuelType, SortOption sortOption, int radius) =>
      dispatch(SettingsLoaded(fuelType, sortOption, radius));
}
