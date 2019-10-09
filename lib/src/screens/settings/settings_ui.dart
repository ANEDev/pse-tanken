import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanken/src/models/fuel_type.dart';

import 'package:tanken/src/screens/settings/settings_bloc.dart';
import 'package:tanken/src/screens/settings/settings_states.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsBloc _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: _settingsBloc,
      builder: (_, SettingsState state) {
        if (state is CurrentSettings || state is DefaultSettings) {
          return SettingsScreenWidget();
        }
        return null; //TODO returns null
      },
    );
  }
}

class SettingsScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsBloc _settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder(
        bloc: _settingsBloc,
        builder: (_, SettingsState state) {
          return Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(16.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Kraftstoffauswahl"),
                      DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: "Diesel",
                            child: Text(
                              "Diesel",
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "Super",
                            child: Text(
                              "Super",
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "Super E10",
                            child: Text(
                              "Super E10",
                            ),
                          ),
                        ],
                        onChanged: (type) {
                          _settingsBloc.onFuelTypeChanged(fuelTypeForString(type));
                        },
                        value: state.fuelType.fuelName,
                        elevation: 2,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        isDense: true,
                        iconSize: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(16.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Suchradius"),
                      SizedBox(width: 140.0,),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) => _settingsBloc.onSearchRadiusChanged(int.parse(value)),
                          decoration: InputDecoration(hintText: "${state.searchRadius}"),
                          textAlign: TextAlign.right,
                          maxLength: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
