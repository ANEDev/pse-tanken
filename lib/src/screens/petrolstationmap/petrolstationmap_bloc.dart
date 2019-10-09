import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';
import 'package:tanken/src/models/petrolstation.dart';
import 'package:tanken/src/repository/repository.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_events.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_states.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  @override
  MapState get initialState => MapEmpty();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is FetchMapEvent) {
      yield MapLoading();
      yield await _fetchPetrolStations(
        fuelType: event.fuelType,
        sortOption: event.sortOption,
        radius: event.radius,
      );
    }
  }

  Future<MapState> _fetchPetrolStations({
    FuelType fuelType,
    SortOption sortOption,
    int radius,
  }) async {
    List<PetrolStation> stations;
    Position position;
    try {
      position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (error) {
      print(error.toString());
      return MapError(error.toString());
    }
    try {
      stations = await RepositoryImpl().getPetrolStationsInRange(
        position.latitude,
        position.longitude,
        rad: radius,
        type: fuelType,
        sort: sortOption,
      );
    } catch (error) {
      return MapError(error.toString());
    }
    return MapLoaded(stations, position);
  }

  void onFetchPetrolStations(
    FuelType fuelType,
    SortOption sortOption,
    int radius,
  ) =>
      dispatch(FetchMapEvent(fuelType: fuelType, sortOption: sortOption, radius: radius));
}
