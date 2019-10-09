import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:tanken/src/models/petrolstation.dart';
import 'package:geolocator/geolocator.dart';


abstract class MapState {}

@immutable
class MapEmpty extends MapState {}

@immutable
class MapLoading extends MapState {}

@immutable
class MapError extends MapState {
  final String errorMessage;

  MapError(this.errorMessage);
}

@immutable
class MapLoaded extends MapState {
  final List<PetrolStation> petrolStations;
  final Position position;
  GoogleMapController mapController;
  MapLoaded(this.petrolStations, this.position, {this.mapController});
}
