import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_bloc.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_states.dart';
import 'package:tanken/src/screens/settings/settings_bloc.dart';
import 'package:tanken/src/screens/settings/settings_states.dart';
import 'package:tanken/src/screens/widgets/error_dialog.dart';
import 'package:tanken/src/screens/widgets/patrolstation_card.dart';

class PetrolStationListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardList();
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PetrolBloc _petrolBloc = BlocProvider.of<PetrolBloc>(context);

    return BlocBuilder(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (_, SettingsState settingsState) {
        return BlocBuilder(
          bloc: _petrolBloc,
          builder: (_, PetrolState state) {
            if (state is PetrolError) {
              return PetrolErrorWidget();
            }
            if (state is PetrolEmpty) {
              _petrolBloc.onFetchPetrolStations(
                settingsState.fuelType,
                settingsState.sortOption,
                settingsState.searchRadius,
              );
              return Text('Empty');
            }
            if (state is PetrolLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PetrolLoaded) {
              return RefreshIndicator(
                onRefresh: () {
                  _petrolBloc.onFetchPetrolStations(
                    settingsState.fuelType,
                    settingsState.sortOption,
                    settingsState.searchRadius,
                  );
                },
                child: ListView.builder(
                  itemBuilder: (_, int index) => PetrolStationCard(
                        petrolStation: state.petrolStations[index],
                        selectedFuelType: settingsState.fuelType.fuelName,
                      ),
                  itemCount: state.petrolStations.length,
                ),
              );
            }
          },
        );
      },
    );
  }
}
