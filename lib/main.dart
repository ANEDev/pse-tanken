import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tanken/src/blocs/state_transiton_supervisor.dart';

import 'src/app.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}
