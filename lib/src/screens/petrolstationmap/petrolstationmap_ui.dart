import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanken/src/models/petrolstation.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_bloc.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_states.dart';
import 'package:tanken/src/screens/settings/settings_bloc.dart';
import 'package:tanken/src/screens/settings/settings_states.dart';
import 'package:tanken/src/screens/widgets/error_dialog.dart';

// TODO FETCH ON LOAD

class PetrolStationMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapView();
  }
}

class PetrolStationMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement custom marker ui
    return null;
  }
}

class MapView extends StatelessWidget {
  GoogleMapController myController;

  @override
  Widget build(BuildContext context) {
    MapBloc _mapBloc = BlocProvider.of<MapBloc>(context);

    return BlocBuilder(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (_, SettingsState settingsState) {
        return BlocBuilder(
          bloc: _mapBloc,
          builder: (_, MapState state) {
            if (state is MapError) {
              return PetrolErrorWidget();
            }
            if (state is MapEmpty) {
              _mapBloc.onFetchPetrolStations(
                settingsState.fuelType,
                settingsState.sortOption,
                settingsState.searchRadius,
              );
              return Text('Empty');
            }
            if (state is MapLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is MapLoaded) {
              return Scaffold(
                body: new Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: (controller) {
                        state.mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            state.position.latitude,
                            state.position.longitude,
                          ),
                          zoom: 16.0),
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      markers: _createMarker(state.petrolStations),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Set<Marker> _createMarker(List<PetrolStation> petrolStations) {
    Set<Marker> markerSet = Set();

    for (var station in petrolStations) {
      var marker = Marker(
        markerId: MarkerId(station.id),
        infoWindow: InfoWindow(
          title: station.brand,
          snippet: station.price.toString(),
        ),
        position: LatLng(
          station.latitude,
          station.longitude,
        ),
      );
      markerSet.add(marker);
    }

    return markerSet;
  }
}
