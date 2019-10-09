import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_bloc.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_states.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_bloc.dart';
import 'package:tanken/src/screens/settings/settings_bloc.dart';
import 'package:tanken/src/screens/settings/settings_states.dart';

class PetrolErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PetrolBloc _petrolBloc = BlocProvider.of<PetrolBloc>(context);
    MapBloc _mapBloc = BlocProvider.of<MapBloc>(context);

    return BlocBuilder(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (_, SettingsState settingsState) {
        return BlocBuilder(
          bloc: _petrolBloc,
          builder: (_, PetrolState state) {
            if (state is PetrolError) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: new RefreshIndicator(
                    onRefresh: () {
                      _petrolBloc.onFetchPetrolStations(
                        settingsState.fuelType,
                        settingsState.sortOption,
                        settingsState.searchRadius,
                      );
                      _mapBloc.onFetchPetrolStations(
                        settingsState.fuelType,
                        settingsState.sortOption,
                        settingsState.searchRadius,
                      );
                    },
                    child: ListView(
                      children: <Widget>[
                        AlertDialog(
                          title: Text(
                            "Error",
                            style: TextStyle(fontSize: 30.0),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Image.asset('assets/error.png'),
                                Text(state.errorMessage)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            } else {
              throw Exception("WTF");
            }
          },
        );
      },
    );
  }
}
