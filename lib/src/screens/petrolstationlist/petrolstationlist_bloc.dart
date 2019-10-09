import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';
import 'package:tanken/src/models/petrolstation.dart';
import 'package:tanken/src/repository/repository.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_events.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_states.dart';

class PetrolBloc extends Bloc<PetrolEvent, PetrolState> {
  @override
  PetrolState get initialState => PetrolEmpty();

  @override
  Stream<PetrolState> mapEventToState(PetrolEvent event) async* {
    if (event is FetchPetrolEvent) {
      yield PetrolLoading();
      yield await _fetchPetrolStations(
        fuelType: event.fuelType,
        sortOption: event.sortOption,
        radius: event.radius,
      );
    }
  }

  Future<PetrolState> _fetchPetrolStations({
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
      return PetrolError(error.toString());
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
      return PetrolError(error.toString());
    }
    return PetrolLoaded(stations);
  }

  void onFetchPetrolStations(
    FuelType fuelType,
    SortOption sortOption,
    int radius,
  ) {
    dispatch(FetchPetrolEvent(fuelType: fuelType, sortOption: sortOption, radius: radius));
  }
}
