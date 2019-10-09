import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanken/src/models/api_sort.dart';
import 'package:tanken/src/models/fuel_type.dart';
import 'package:tanken/src/repository/settings_repository.dart';
import 'package:tanken/src/screens/petrolstationlist/petrolstationlist_bloc.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_bloc.dart';
import 'package:tanken/src/screens/petrolstationmap/petrolstationmap_ui.dart';
import 'package:tanken/src/screens/settings/settings_bloc.dart';
import 'package:tanken/src/screens/settings/settings_ui.dart';
import 'package:tanken/src/screens/widgets/sort_order_dialog.dart';
import 'package:tanken/src/screens/statistics/statistics_ui.dart';

import 'screens/petrolstationlist/petrolstationlist_ui.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TANKO',
      theme: ThemeData(
        accentColor: Colors.grey,
        cardColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: HomePage(title: 'TANKO'),
      routes: <String, WidgetBuilder>{
        '/petrolstationlist': (BuildContext context) =>
            PetrolStationListScreen(),
        '/petrolstationmap': (BuildContext context) => PetrolStationMapScreen(),
        '/statistics': (BuildContext context) => StatisticsScreen(),
        '/settings': (BuildContext context) => SettingsScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PetrolBloc _petrolBloc;
  SettingsBloc _settingsBloc;
  MapBloc _mapBloc;

  @override
  void initState() {
    super.initState();
    _petrolBloc = PetrolBloc();
    _mapBloc = MapBloc();
    _settingsBloc = SettingsBloc(_petrolBloc, _mapBloc);
    checkDatabaseContent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<SettingsBloc>(bloc: _settingsBloc),
        BlocProvider<PetrolBloc>(bloc: _petrolBloc),
        BlocProvider<MapBloc>(bloc: _mapBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
              Visibility(
                visible: _selectedIndex == 0,
                child: IconButton(
                  color: Colors.grey,
                  icon: Icon(Icons.sort),
                  onPressed: () => showSortOrderDialog(context),
                ),
              )
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            Offstage(
              offstage: _selectedIndex != 0,
              child: TickerMode(
                enabled: _selectedIndex == 0,
                child: PetrolStationListScreen(),
              ),
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: TickerMode(
                enabled: _selectedIndex == 1,
                child: PetrolStationMapScreen(),
              ),
            ),
            Offstage(
              offstage: _selectedIndex != 2,
              child: TickerMode(
                enabled: _selectedIndex == 2,
                child: StatisticsScreen(),
              ),
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: TickerMode(
                enabled: _selectedIndex == 3,
                child: SettingsScreen(),
              ),
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Image.asset(
                'assets/Layer0.png',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 35,
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/Layer1.png',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu, color: Colors.black54),
              title: Text(
                'Menu',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map, color: Colors.black54),
              title: Text(
                'Map',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline, color: Colors.black54),
              title: Text(
                'Statistics',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black54),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              this._selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }

  void showSortOrderDialog(BuildContext context) async {
    SortOption sortOption = await asyncSimpleDialog(context);
    print(sortOption.sortName);
    _settingsBloc.onSortOrderChanged(sortOption);
  }

  @override
  void dispose() {
    _settingsBloc.dispose();
    _petrolBloc.dispose();
    _mapBloc.dispose();
    super.dispose();
  }

  void checkDatabaseContent() async {
    int radius;
    FuelType fuelType;
    SortOption sortOption;
    SettingsRepositoryImpl settingsRepo = SettingsRepositoryImpl();
    try {
      radius = await settingsRepo.getSearchRadius();
      if (radius==null){
        radius = 5;
      }
      print('Radius: ${radius}');
    } catch (error) {
      print('Defaultradius: ${_settingsBloc.currentState.searchRadius}');
      radius = _settingsBloc.currentState.searchRadius;
    }
    try {
      fuelType = await settingsRepo.getFuelType();
      print('FuelType: ${fuelType.fuelName}');
    } catch (error) {
      print(_settingsBloc.currentState.fuelType);
      fuelType = _settingsBloc.currentState.fuelType;
    }
    try {
      sortOption = await settingsRepo.getListSortOrder();
      print('SortOption: ${sortOption.sortName}');
    } catch (error) {
      print(_settingsBloc.currentState.sortOption);
      sortOption = _settingsBloc.currentState.sortOption;
    }
    _settingsBloc.onSettingsLoaded(fuelType, sortOption, radius);
  }
}
