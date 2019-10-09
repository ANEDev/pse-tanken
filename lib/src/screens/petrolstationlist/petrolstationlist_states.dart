import 'package:meta/meta.dart';
import 'package:tanken/src/models/petrolstation.dart';

abstract class PetrolState {}

@immutable
class PetrolEmpty extends PetrolState {}

@immutable
class PetrolLoading extends PetrolState {}

@immutable
class PetrolError extends PetrolState {
  final String errorMessage;

  PetrolError(this.errorMessage);
}

@immutable
class PetrolLoaded extends PetrolState {
  final List<PetrolStation> petrolStations;

  PetrolLoaded(this.petrolStations);
}
